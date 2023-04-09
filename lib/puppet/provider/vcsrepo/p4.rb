# frozen_string_literal: true

require File.join(File.dirname(__FILE__), '..', 'vcsrepo')

Puppet::Type.type(:vcsrepo).provide(:p4, parent: Puppet::Provider::Vcsrepo) do
  desc 'Supports Perforce depots'

  has_features :filesystem_types, :reference_tracking, :p4config

  def create
    check_force
    # create or update client
    create_client(client_name)

    # if source provided, sync client
    source = @resource.value(:source)
    if source
      revision = @resource.value(:revision)
      sync_client(source, revision)
    end

    update_owner
  end

  def working_copy_exists?
    # Check if the server is there, or raise error
    p4(['info'], marshal: false)

    # Check if workspace is setup
    args = ['where']
    args.push("#{@resource.value(:path)}/...")
    hash = p4(args, raise: false)

    (hash['code'] != 'error')
  end

  def exists?
    working_copy_exists?
  end

  def destroy
    args = ['client']
    args.push('-d', '-f')
    args.push(client_name)
    p4(args)
    FileUtils.rm_rf(@resource.value(:path))
  end

  def latest?
    rev = revision
    if rev
      (rev >= latest)
    else
      true
    end
  end

  def latest
    args = ['changes']
    args.push('-m1', @resource.value(:source))
    hash = p4(args)

    hash['change'].to_i
  end

  def revision
    args = ['cstat']
    args.push(@resource.value(:source))
    hash = p4(args, marshal: false)
    hash = marshal_cstat(hash)

    revision = 0
    if hash && hash['code'] != 'error'
      hash['data'].each do |c|
        if c['status'] == 'have'
          change = c['change'].to_i
          revision = change if change > revision
        end
      end
    end
    revision
  end

  def revision=(desired)
    sync_client(@resource.value(:source), desired)
    update_owner
  end

  def source
    args = ['where']
    args.push("#{@resource.value(:path)}/...")
    hash = p4(args, raise: false)

    hash['depotFile']
  end

  def source=(_desired)
    create # recreate
  end

  private

  def update_owner
    set_ownership_and_permissions
  end

  # Sync the client workspace files to head or specified revision.
  # Params:
  # +source+:: Depot path to sync
  # +revision+:: Perforce change list to sync to (optional)
  def sync_client(source, revision)
    Puppet.debug "Syncing: #{source}"
    args = ['sync']
    if revision
      args.push(source + "@#{revision}")
    else
      args.push(source)
    end
    p4(args)
  end

  # Returns the name of the Perforce client workspace
  def client_name
    p4config = @resource.value(:p4config)

    # default (generated) client name
    path = @resource.value(:path)
    host = Facter.value('hostname')
    default = "puppet-#{Digest::MD5.hexdigest(path + host)}"

    # check config for client name
    set_client = nil
    if p4config && File.file?(p4config)
      open(p4config) do |f|
        m = f.grep(%r{^P4CLIENT=}).pop
        p = %r{^P4CLIENT=(.*)$}
        set_client = p.match(m)[1] if m
      end
    end

    set_client || ENV['P4CLIENT'] || default
  end

  # Create (or update) a client workspace spec.
  # If a client name is not provided then a hash based on the path is used.
  # Params:
  # +client+:: Name of client workspace
  # +path+:: The Root location of the Perforce client workspace
  def create_client(client)
    Puppet.debug "Creating client: #{client}"

    # fetch client spec
    hash = parse_client(client)
    hash['Root'] = @resource.value(:path)
    hash['Description'] = 'Generated by Puppet VCSrepo'

    # check is source is a Stream
    source = @resource.value(:source)
    if source
      parts = source.split(%r{/})
      if parts && parts.length >= 4
        source = "//#{parts[2]}/#{parts[3]}"
        streams = p4(['streams', source], raise: false)
        if streams['code'] == 'stat'
          hash['Stream'] = streams['Stream']
          notice "Streams#{streams['Stream'].inspect}"
        end
      end
    end

    # save client spec
    save_client(hash)
  end

  # Fetches a client workspace spec from Perforce and returns a hash map representation.
  # Params:
  # +client+:: name of the client workspace
  def parse_client(client)
    args = ['client']
    args.push('-o', client)
    p4(args)
  end

  # Saves the client workspace spec from the given hash
  # Params:
  # +hash+:: hash map of client spec
  def save_client(hash)
    spec = ''
    view = "\nView:\n"

    hash.keys.sort.each do |k|
      v = hash[k]
      next if k == 'code'

      if k.to_s.include?('View')
        view += "\t#{v}\n"
      else
        spec += "#{k}: #{v}\n"
      end
    end
    spec += view

    args = ['client']
    args.push('-i')
    p4(args, input: spec, marshal: false)
  end

  # Sets Perforce Configuration environment.
  # P4CLIENT generated, but overwitten if defined in config.
  def config
    p4config = @resource.value(:p4config)

    cfg = {}
    cfg.store 'P4CONFIG', p4config if p4config
    cfg.store 'P4CLIENT', client_name
    cfg
  end

  def p4(args, options = {})
    # Merge custom options with defaults
    opts = {
      raise: true, # Raise errors
      marshal: true # Marshal output
    }.merge(options)

    cmd = ['p4']
    cmd.push '-R' if opts[:marshal]
    cmd.push args
    cmd_str = cmd.respond_to?(:join) ? cmd.join(' ') : cmd

    Puppet.debug "environment: #{config}"
    Puppet.debug "command: #{cmd_str}"

    hash = {}
    Open3.popen3(config, cmd_str) do |i, o, e, t|
      # Send input stream if provided
      if opts[:input]
        Puppet.debug "input:\n#{opts[:input]}"
        i.write opts[:input]
        i.close
      end

      if opts[:marshal]
        hash = Marshal.dump(o)
      else
        hash['data'] = o.read
      end

      # Raise errors, Perforce or Exec
      raise Puppet::Error, "\nP4: #{e.read}" if opts[:raise] && !e.eof && t.value != 0
      raise Puppet::Error, "\nP4: #{hash['data']}" if opts[:raise] && hash['code'] == 'error' && t.value != 0
    end

    Puppet.debug "hash: #{hash}\n"
    hash
  end

  # helper method as cstat does not Marshal
  def marshal_cstat(hash)
    data = hash['data']
    code = 'error'

    list = []
    change = {}
    data.each_line do |l|
      p = %r{^\.\.\. (.*) (.*)$}
      m = p.match(l)
      next unless m

      change[m[1]] = m[2]
      next unless m[1] == 'status'

      code = 'stat'
      list.push change
      change = {}
    end

    hash = {}
    hash.store 'code', code
    hash.store 'data', list
    hash
  end
end
