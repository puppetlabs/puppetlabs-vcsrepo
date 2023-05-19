# frozen_string_literal: true

require File.join(File.dirname(__FILE__), '..', 'vcsrepo')

Puppet::Type.type(:vcsrepo).provide(:git, parent: Puppet::Provider::Vcsrepo) do
  desc 'Supports Git repositories'

  has_features :bare_repositories, :reference_tracking, :ssh_identity, :multiple_remotes,
               :user, :depth, :branch, :submodules, :safe_directory, :hooks_allowed,
               :umask, :http_proxy

  def create
    check_force
    raise("Cannot set a revision (#{@resource.value(:revision)}) on a bare repository") if @resource.value(:revision) && ensure_bare_or_mirror?

    if @resource.value(:source)
      clone_repository(default_url, @resource.value(:path))
      update_remotes(@resource.value(:source))
      set_mirror if @resource.value(:ensure) == :mirror && @resource.value(:source).is_a?(Hash)
      self.skip_hooks = @resource.value(:skip_hooks) unless @resource.value(:skip_hooks).nil?

      checkout if @resource.value(:revision)
      update_submodules if !ensure_bare_or_mirror? && @resource.value(:submodules) == :true

    else
      raise('Cannot init repository with mirror option, try bare instead') if @resource.value(:ensure) == :mirror

      init_repository
      self.skip_hooks = @resource.value(:skip_hooks) unless @resource.value(:skip_hooks).nil?
    end
    update_owner_and_excludes
  end

  def destroy
    remove_safe_directory
    FileUtils.rm_rf(@resource.value(:path))
  end

  # Checks to see if the current revision is equal to the revision on the
  # remote (whether on a branch, tag, or reference)
  #
  # @return [Boolean] Returns true if the repo is on the latest revision
  def latest?
    revision == latest_revision
  end

  # Just gives the `should` value that we should be setting the repo to if
  # latest? returns false
  #
  # @return [String] Returns the target sha/tag/branch
  def latest
    if !@resource.value(:revision) && (branch = on_branch?)
      branch
    else
      @resource.value(:revision)
    end
  end

  # Get the current revision of the repo (tag/branch/sha)
  #
  # @return [String] Returns the branch/tag if the current sha matches the
  #                  remote; otherwise returns the current sha.
  def revision
    # HEAD is the default, but lets just be explicit here.
    get_revision('HEAD')
  end

  # Is passed the desired reference, whether a tag, rev, or branch. Should
  # handle transitions from a rev/branch/tag to a rev/branch/tag. Detached
  # heads should be treated like bare revisions.
  #
  # @param [String] desired The desired revision to which the repo should be
  #                         set.
  def revision=(desired)
    # just checkout tags and shas; fetch has already happened so they should be updated.
    checkout(desired)
    # branches require more work.
    if local_branch_revision?(desired)
      # reset instead of pull to avoid merge conflicts. assuming remote is
      # updated and authoritative.
      # TODO might be worthwhile to have an allow_local_changes param to decide
      # whether to reset or pull when we're ensuring latest.
      if @resource.value(:source)
        at_path { git_with_identity('reset', '--hard', "#{@resource.value(:remote)}/#{desired}") }
      else
        at_path { git_with_identity('reset', '--hard', desired.to_s) }
      end
    end
    # TODO: Would this ever reach here if it is bare?
    update_submodules if !ensure_bare_or_mirror? && @resource.value(:submodules) == :true
    update_owner_and_excludes
  end

  def bare_exists?
    bare_git_config_exists? && !working_copy_exists?
  end

  def ensure_bare_or_mirror?
    [:bare, :mirror].include? @resource.value(:ensure)
  end

  # If :source is set to a hash (for supporting multiple remotes),
  # we search for the URL for :remote. If it doesn't exist,
  # we throw an error. If :source is just a string, we use that
  # value for the default URL.
  def default_url
    return @resource.value(:source) unless @resource.value(:source).is_a?(Hash)
    return @resource.value(:source)[@resource.value(:remote)] if @resource.value(:source).key?(@resource.value(:remote))

    raise("You must specify the URL for remote '#{@resource.value(:remote)}' in the :source hash")
  end

  def working_copy_exists?
    # NOTE: a change in the `default_url` will tell the type that this repo
    # doesn't exist (i.e. it triggers a "not the same repository" error).
    # Thus, changing the `source` property from a string to a string (which
    # changes the origin url), or if the @resource.value(:remote)'s url is
    # changed, the provider will require force.
    return false unless File.directory?(File.join(@resource.value(:path), '.git'))

    at_path do
      if @resource.value(:source)
        begin
          return git_with_identity('config', '--get', "remote.#{@resource.value(:remote)}.url").chomp == default_url
        rescue Puppet::ExecutionFailure
          return false
        end
      else
        begin
          git_with_identity('status')
          return true
        rescue Puppet::ExecutionFailure
          return false
        end
      end
    end
  end

  def exists?
    update_safe_directory
    working_copy_exists? || bare_exists?
  end

  def remove_remote(remote)
    at_path do
      git_with_identity('remote', 'remove', remote)
    end
  end

  def update_remote_url(remote_name, remote_url)
    current = git_with_identity('config', '-l')

    return if remote_url.nil?

    # Check if remote exists at all, regardless of URL.
    # If remote doesn't exist, add it
    if !current.include? "remote.#{remote_name}.url"
      git_with_identity('remote', 'add', remote_name, remote_url)
      true

      # If remote exists, but URL doesn't match, update URL
    elsif !current.include? "remote.#{remote_name}.url=#{remote_url}"
      git_with_identity('remote', 'set-url', remote_name, remote_url)
      true
    else
      false
    end
  end

  def source
    at_path do
      remotes = git_with_identity('remote').split("\n")

      return git_with_identity('config', '--get', "remote.#{remotes[0]}.url").chomp if remotes.size == 1

      remotes.to_h do |remote|
        [remote, git_with_identity('config', '--get', "remote.#{remote}.url").chomp]
      end
    end
  end

  def source=(desired)
    # NOTE: a change in the `default_url` will tell the type that this repo
    # doesn't exist (i.e. it triggers a "not the same repository" error).
    # Thus, a change from a string to a string (which changes the origin url),
    # or if the @resource.value(:remote)'s url is changed, the provider will
    # require force, without ever reaching this block. The recreation is
    # duplicated here in case something changes in the `working_copy_exists?`
    # logic.
    current = source
    if current.is_a?(Hash)
      current.each_key do |remote|
        remove_remote(remote) if desired.is_a?(Hash) && !desired.key?(remote)
        remove_remote(remote) if desired.is_a?(String) && remote != @resource.value(:remote)
      end
    end
    if current.is_a?(String) && desired.is_a?(String)
      create # recreate
    else
      update_remotes(desired)
    end
  end

  def update_remotes(remotes)
    do_update = false

    # If supplied source is a hash of remote name and remote url pairs, then
    # we loop around the hash. Otherwise, we assume single url specified
    # in source property
    if remotes.is_a?(Hash)
      remotes.keys.sort.each do |remote_name|
        remote_url = remotes[remote_name]
        at_path { do_update |= update_remote_url(remote_name, remote_url) }
      end
    else
      at_path { do_update |= update_remote_url(@resource.value(:remote), remotes) }
    end

    # If at least one remote was added or updated, then we must
    # call the 'git remote update' command
    at_path { git_remote_action('remote', 'update') } if do_update == true
  end

  def update_references
    fetch_tags_args = ['fetch', '--tags']
    git_ver = git_version
    fetch_tags_args.push('--force') if Gem::Version.new(git_ver) >= Gem::Version.new('2.20.0')
    at_path do
      git_remote_action('fetch', @resource.value(:remote))
      git_remote_action(*fetch_tags_args, @resource.value(:remote))
      update_owner_and_excludes
    end
  end

  # Convert working copy to bare
  #
  # Moves:
  #   <path>/.git
  # to:
  #   <path>/
  # and sets core.bare=true, and calls `set_mirror` if appropriate
  def convert_working_copy_to_bare
    return unless working_copy_exists? && !bare_exists?

    notice 'Converting working copy repository to bare repository'
    FileUtils.mv(File.join(@resource.value(:path), '.git'), tempdir)
    FileUtils.rm_rf(@resource.value(:path))
    FileUtils.mv(tempdir, @resource.value(:path))
    at_path do
      exec_git('config', '--local', '--bool', 'core.bare', 'true')
      return unless @resource.value(:ensure) == :mirror
      raise('Cannot have empty repository that is also a mirror.') unless @resource.value(:source)

      set_mirror
    end
  end

  # Convert bare to working copy
  #
  # Moves:
  #   <path>/
  # to:
  #   <path>/.git
  # and sets core.bare=false, and calls `set_no_mirror` if appropriate
  def convert_bare_to_working_copy
    notice 'Converting bare repository to working copy repository'
    FileUtils.mv(@resource.value(:path), tempdir)
    FileUtils.mkdir(@resource.value(:path))
    FileUtils.mv(tempdir, File.join(@resource.value(:path), '.git'))
    if commits?
      at_path do
        exec_git('config', '--local', '--bool', 'core.bare', 'false')
        reset('HEAD')
        git_with_identity('checkout', '--force')
        update_owner_and_excludes
      end
    end
    set_no_mirror if mirror?
  end

  def mirror?
    at_path do
      git_with_identity('config', '--get-regexp', 'remote\..*\.mirror')
      return true
    rescue Puppet::ExecutionFailure
      return false
    end
  end

  def set_mirror
    at_path do
      if @resource.value(:source).is_a?(String)
        git_with_identity('config', "remote.#{@resource.value(:remote)}.mirror", 'true')
      else
        @resource.value(:source).each_key do |remote|
          git_with_identity('config', "remote.#{remote}.mirror", 'true')
        end
      end
    end
  end

  def set_no_mirror
    at_path do
      if @resource.value(:source).is_a?(String)
        begin
          exec_git('config', '--unset', "remote.#{@resource.value(:remote)}.mirror")
        rescue Puppet::ExecutionFailure
          next
        end
      else
        @resource.value(:source).each_key do |remote|
          exec_git('config', '--unset', "remote.#{remote}.mirror")
        rescue Puppet::ExecutionFailure
          next
        end
      end
    end
  end

  def skip_hooks
    git_ver = git_version
    config_args = ['config']
    config_args.push('--local') if Gem::Version.new(git_ver) >= Gem::Version.new('1.7.4')
    at_path do
      begin
        d = git_with_identity(*config_args, '--get', 'core.hooksPath')
      rescue Puppet::ExecutionFailure
        return :false
      end
      return :true if d.chomp == '/dev/null'

      :false
    end
  end

  def skip_hooks=(desired)
    git_ver = git_version
    config_args = ['config']
    config_args.push('--local') if Gem::Version.new(git_ver) >= Gem::Version.new('1.7.4')
    at_path do
      if desired == :true
        exec_git(*config_args, 'core.hooksPath', '/dev/null')
      elsif desired == :false
        begin
          exec_git(*config_args, '--unset', 'core.hooksPath')
        rescue Puppet::ExecutionFailure
          next
        end
      end
    end
  end

  private

  # @!visibility private
  def bare_git_config_exists?
    return false unless File.exist?(File.join(@resource.value(:path), 'config'))

    begin
      at_path { git_with_identity('config', '--list', '--file', 'config') }
      true
    rescue Puppet::ExecutionFailure
      false
    end
  end

  # @!visibility private
  def clone_repository(source, path)
    args = ['clone']
    if @resource.value(:depth)&.to_i&.positive?
      args.push('--depth', @resource.value(:depth).to_s)
      args.push('--branch', @resource.value(:revision).to_s) if @resource.value(:revision) && !@resource.value(:branch)
    end
    args.push('--branch', @resource.value(:branch).to_s) if @resource.value(:branch)

    case @resource.value(:ensure)
    when :bare then args << '--bare'
    when :mirror then args << '--mirror'
    end

    args.push('--origin', @resource.value(:remote)) if @resource.value(:remote) != 'origin'
    if working_copy_exists?
      notice 'Repo has already been cloned'
    else
      args.push(source, path)
      Dir.chdir('/') do
        git_remote_action(*args)
      end
    end
  end

  # @!visibility private
  def init_repository
    if @resource.value(:ensure) == :bare && working_copy_exists?
      convert_working_copy_to_bare
    elsif @resource.value(:ensure) == :present && bare_exists?
      convert_bare_to_working_copy
    else
      # normal init
      FileUtils.mkdir(@resource.value(:path))
      FileUtils.chown(@resource.value(:user), nil, @resource.value(:path)) if @resource.value(:user)
      args = ['init']
      args << '--bare' if @resource.value(:ensure) == :bare
      at_path do
        git_with_identity(*args)
      end
    end
  end

  # @!visibility private
  def commits?
    at_path do
      begin
        commits = git_with_identity('rev-list', '--all', '--count').to_i
      rescue Puppet::ExecutionFailure
        commits = 0
      end
      return commits.positive?
    end
  end

  # Will checkout a rev/branch/tag using the locally cached versions. Does not
  # handle upstream branch changes
  # @!visibility private
  def checkout(revision = @resource.value(:revision))
    keep_local_changes = @resource.value(:keep_local_changes)
    stash if keep_local_changes == :true
    if !local_branch_revision?(revision) && remote_branch_revision?(revision)
      # non-locally existant branches (perhaps switching to a branch that has never been checked out)
      at_path { git_with_identity('checkout', '--force', '-b', revision, '--track', "#{@resource.value(:remote)}/#{revision}") }
    else
      # tags, locally existant branches (perhaps outdated), and shas
      at_path { git_with_identity('checkout', '--force', revision) }
    end
    unstash if keep_local_changes == :true
  end

  # @!visibility private
  def reset(desired)
    at_path do
      git_with_identity('reset', '--hard', desired)
    end
  end

  # @!visibility private
  def update_submodules
    at_path do
      git_with_identity('submodule', 'update', '--init', '--recursive')
    end
  end

  # Determins if the branch exists at the upstream but has not yet been locally committed
  # @!visibility private
  def remote_branch_revision?(revision = @resource.value(:revision))
    # git < 1.6 returns '#{@resource.value(:remote)}/#{revision}'
    # git 1.6+ returns 'remotes/#{@resource.value(:remote)}/#{revision}'
    branch = at_path { branches.grep %r{(remotes/)?#{@resource.value(:remote)}/#{revision}$} }
    branch unless branch.empty?
  end

  # Determins if the branch is already cached locally
  # @!visibility private
  def local_branch_revision?(revision = @resource.value(:revision))
    at_path { branches.include?(revision) }
  end

  # @!visibility private
  def tag_revision?(revision = @resource.value(:revision))
    at_path { tags.include?(revision) }
  end

  # @!visibility private
  def branches
    at_path { git_with_identity('branch', '--no-color', '-a') }.tr('*', ' ').split(%r{\n}).map(&:strip)
  end

  # git < 2.4 returns 'detached from'
  # git 2.4+ returns 'HEAD detached at'
  # @!visibility private
  def on_branch?
    at_path do
      matches = git_with_identity('branch', '--no-color', '-a').match %r{\*\s+(.*)}
      matches[1] unless %r{(\(detached from|\(HEAD detached at|\(no branch)}.match?(matches[1])
    end
  end

  # @!visibility private
  def tags
    at_path { git_with_identity('tag', '-l') }.split(%r{\n}).map(&:strip)
  end

  # @!visibility private
  def set_excludes
    # Excludes may be an Array or a String.
    at_path do
      open('.git/info/exclude', 'w') do |f|
        if @resource.value(:excludes).respond_to?(:each)
          @resource.value(:excludes).each { |ex| f.puts ex }
        else
          f.puts @resource.value(:excludes)
        end
      end
    end
  end

  # @!visibility private
  def stash
    at_path { git_with_identity('stash', 'save') }
  end

  # @!visibility private
  def unstash
    at_path { git_with_identity('stash', 'pop') }
  end

  # Finds the latest revision or sha of the current branch if on a branch, or
  # of HEAD otherwise.
  # @note Calls create which can forcibly destroy and re-clone the repo if
  #       force => true
  # @see get_revision
  #
  # @!visibility private
  # @return [String] Returns the output of get_revision
  def latest_revision
    # TODO: Why is create called here anyway?
    create if @resource.value(:force) && working_copy_exists?
    create unless working_copy_exists?

    branch = on_branch?
    return get_revision("#{@resource.value(:remote)}/#{branch}") if branch

    get_revision
  end

  # Returns the current revision given if the revision is a tag or branch and
  # matches the current sha. If the current sha does not match the sha of a tag
  # or branch, then it will just return the sha (ie, is not in sync)
  #
  # @!visibility private
  #
  # @param [String] rev The revision of which to check if it is current
  # @return [String] Returns the tag/branch of the current repo if it's up to
  #                  date; otherwise returns the sha of the requested revision.
  def get_revision(rev = 'HEAD')
    unless @resource.value(:source)
      status = at_path { git_with_identity('status') }
      is_it_new = status =~ %r{Initial commit|No commits yet}
      if is_it_new
        status =~ %r{On branch (.*)}
        branch = Regexp.last_match(1)
        return branch
      end
    end
    current = at_path { git_with_identity('rev-parse', rev).strip }
    if @resource.value(:revision) == current
      # if already pointed at desired revision, it must be a SHA, so just return it
      return current
    end

    update_references if @resource.value(:source)
    if @resource.value(:revision)
      canonical = if tag_revision?
                    # git-rev-parse will give you the hash of the tag object itself rather
                    # than the commit it points to by default. Using tag^0 will return the
                    # actual commit.
                    at_path { git_with_identity('rev-parse', "#{@resource.value(:revision)}^0").strip }
                  elsif local_branch_revision?
                    at_path { git_with_identity('rev-parse', @resource.value(:revision)).strip }
                  elsif remote_branch_revision?
                    at_path { git_with_identity('rev-parse', "#{@resource.value(:remote)}/#{@resource.value(:revision)}").strip }
                  else
                    # look for a sha (could match invalid shas)
                    at_path { git_with_identity('rev-parse', '--revs-only', @resource.value(:revision)).strip }
                  end
      raise("#{@resource.value(:revision)} is not a local or remote ref") if canonical.nil? || canonical.empty?

      current = @resource.value(:revision) if current == canonical
    end
    current
  end

  # @!visibility private
  def update_owner_and_excludes
    set_ownership if @resource.value(:owner) || @resource.value(:group)
    set_excludes if @resource.value(:excludes)
  end

  def git_version
    exec_git('--version').match(%r{[0-9]+\.[0-9]+\.[0-9]+(\.[0-9]+)?})[0]
  end

  # @!visibility private
  def safe_directories
    args = ['config', '--system', '--get-all', 'safe.directory']
    begin
      d = git_with_identity(*args) || ''
      d.split('\n')
       .reject(&:empty?)
       .map(&:chomp)
    rescue Puppet::ExecutionFailure
      []
    end
  end

  # @!visibility private
  def update_safe_directory
    # If the owner parameter is not set, then we don't need to do anything.
    return unless @resource.value(:owner)

    if should_add_safe_directory?
      add_safe_directory
    elsif should_remove_safe_directory?
      remove_safe_directory
    end
  end

  # @!visibility private
  def add_safe_directory
    notice("Adding '#{@resource.value(:path)}' to safe directory list")
    args = ['config', '--system', '--add', 'safe.directory', @resource.value(:path)]
    git_with_identity(*args)
  end

  # @!visibility private
  def remove_safe_directory
    return unless safe_directories.include?(@resource.value(:path))

    notice("Removing '#{@resource.value(:path)}' from safe directory list")
    args = ['config', '--system', '--unset', 'safe.directory', @resource.value(:path)]
    git_with_identity(*args)
  end

  # @!visibility private
  def should_add_safe_directory?
    (@resource.value(:owner) != @resource.value(:user)) && # user and owner should be different
      @resource.value(:safe_directory) && # safe_directory should be true
      !safe_directories.include?(@resource.value(:path)) # directory should not already be in the list
  end

  # @!visibility private
  def should_remove_safe_directory?
    !@resource.value(:safe_directory) && # safe_directory should be false
      safe_directories.include?(@resource.value(:path)) # directory should be in the list
  end

  # @!visibility private
  def git_remote_action(*args)
    proxy = @resource.value(:http_proxy)
    if proxy
      if proxy.is_a?(Hash)
        # Per-remote proxy support. This may or may not match the actual
        # remotes in use, but specifying proxies for unused remotes is not
        # harmful.
        proxy.each do |remote, url|
          args.unshift('-c', "remote.#{remote}.proxy=#{url}")
        end
      else
        args.unshift('-c', "http.proxy=#{proxy}")
      end
    end
    git_with_identity(*args)
  end

  # @!visibility private
  def git_with_identity(*args)
    if @resource.value(:trust_server_cert) == :true
      git_ver = git_version
      git_ver_err = "Can't set sslVerify to false, the -c parameter is not supported in Git #{git_ver}. Please install Git 1.7.2 or higher."
      return raise(git_ver_err) unless Gem::Version.new(git_ver) >= Gem::Version.new('1.7.2')

      args.unshift('-c', 'http.sslVerify=false')
    end

    if @resource.value(:identity)
      git_ver = git_version
      if Gem::Version.new(git_ver) >= Gem::Version.new('2.3.0')
        # GIT_SSH_COMMAND was introduced in version 2.3.0.
        git_ssh_with_identity_ssh_command(*args)
      else
        git_ssh_with_identity_ssh_file(*args)
      end
    else
      exec_git(*args)
    end
  end

  # @!visibility private
  def git_ssh_with_identity_ssh_command(*args)
    ssh_opts = {
      IgnoreUnknown: 'IdentityAgent',
      IdentitiesOnly: 'yes',
      IdentityAgent: 'none',
      PasswordAuthentication: 'no',
      KbdInteractiveAuthentication: 'no'
    }
    ssh_command = "ssh -i #{@resource.value(:identity)} "
    ssh_command += ssh_opts.map { |option, value| "-o \"#{option} #{value}\"" }.join ' '

    env_git_ssh_command_save = ENV.fetch('GIT_SSH_COMMAND', nil)
    ENV['GIT_SSH_COMMAND'] = ssh_command

    ret = exec_git(*args)

    ENV['GIT_SSH_COMMAND'] = env_git_ssh_command_save

    ret
  end

  # @!visiblity private
  def git_ssh_with_identity_ssh_file(*args)
    Tempfile.open('git-helper') do |f|
      f.puts '#!/bin/sh'
      f.puts 'SSH_AUTH_SOCKET='
      f.puts 'export SSH_AUTH_SOCKET'
      f.puts 'exec ssh -oStrictHostKeyChecking=no -oPasswordAuthentication=no -oKbdInteractiveAuthentication=no ' \
             "-oChallengeResponseAuthentication=no -oConnectTimeout=120 -i #{@resource.value(:identity)} $*"
      f.close

      FileUtils.chmod(0o755, f.path)

      env_git_ssh_save = ENV.fetch('GIT_SSH', nil)
      ENV['GIT_SSH'] = f.path

      ret = exec_git(*args)

      ENV['GIT_SSH'] = env_git_ssh_save

      ret
    end
  end

  # Execute git with the given args, running it as the user specified.
  def exec_git(*args)
    exec_args = {
      failonfail: true,
      combine: true,
      custom_environment: { 'HOME' => Etc.getpwuid(Process.uid).dir }
    }

    if @resource.value(:user) && @resource.value(:user) != Facter['id'].value
      exec_args[:custom_environment] = { 'HOME' => Etc.getpwnam(@resource.value(:user)).dir }
      exec_args[:uid] = @resource.value(:user)
    end
    withumask do
      Puppet::Util::Execution.execute([:git, args], **exec_args)
    end
  end
end
