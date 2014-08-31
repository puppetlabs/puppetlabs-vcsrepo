require File.join(File.dirname(__FILE__), '..', 'vcsrepo')

Puppet::Type.type(:vcsrepo).provide(:git, :parent => Puppet::Provider::Vcsrepo) do
  desc "Supports Git repositories"

  ##TODO modify the commands below so that the su - is included
  commands :git => 'git'
  optional_commands :su  => 'su'

  has_features :bare_repositories, :reference_tracking, :ssh_identity, :multiple_remotes, :user, :depth

  def create
    if @resource.value(:revision) and @resource.value(:ensure) == :bare
      fail("Cannot set a revision (#{@resource.value(:revision)}) on a bare repository")
    end
    if !@resource.value(:source)
      init_repository(@resource.value(:path))
    else
      clone_repository(@resource.value(:source), @resource.value(:path))
      if @resource.value(:revision)
        checkout
      end
      if @resource.value(:ensure) != :bare
        update_submodules
      end
    end
    update_owner_and_excludes
  end

  def destroy
    FileUtils.rm_rf(@resource.value(:path))
  end

  # Checks to see if the current revision is equal to the revision on the
  # remote (whether on a branch, tag, or reference)
  #
  # @return [Boolean] Returns true if the repo is on the latest revision
  def latest?
    return revision == latest_revision
  end

  # Just gives the `should` value that we should be setting the repo to if
  # latest? returns false
  #
  # @return [String] Returns the target sha/tag/branch
  def latest
    @resource.value(:revision)
  end

  # Get the current revision of the repo (tag/branch/sha)
  #
  # @return [String] Returns the branch/tag if the current sha matches the
  #                  remote; otherwise returns the current sha.
  def revision
    #HEAD is the default, but lets just be explicit here.
    get_revision('HEAD')
  end

  # Is passed the desired reference, whether a tag, rev, or branch. Should
  # handle transitions from a rev/branch/tag to a rev/branch/tag. Detached
  # heads should be treated like bare revisions.
  #
  # @param [String] desired The desired revision to which the repo should be
  #                         set.
  def revision=(desired)
    #just checkout tags and shas; fetch has already happened so they should be updated.
    checkout(desired)
    #branches require more work.
    if local_branch_revision?(desired)
      #reset instead of pull to avoid merge conflicts. assuming remote is
      #updated and authoritative.
      #TODO might be worthwhile to have an allow_local_changes param to decide
      #whether to reset or pull when we're ensuring latest.
      at_path { git_with_identity('reset', '--hard', "#{@resource.value(:remote)}/#{desired}") }
    end
    #TODO Would this ever reach here if it is bare?
    if @resource.value(:ensure) != :bare
      update_submodules
    end
    update_owner_and_excludes
  end

  def bare_exists?
    bare_git_config_exists? && !working_copy_exists?
  end

  def working_copy_exists?
    File.directory?(File.join(@resource.value(:path), '.git'))
  end

  def exists?
    working_copy_exists? || bare_exists?
  end

  def update_remote_origin_url
    current = git_with_identity('config', "remote.#{@resource.value(:remote)}.url")
    unless @resource.value(:source).nil?
      if current.nil? or current.strip != @resource.value(:source)
        git_with_identity('config', "remote.#{@resource.value(:remote)}.url", @resource.value(:source))
      end
    end
  end

  def update_references
    at_path do
      update_remote_origin_url
      git_with_identity('fetch', @resource.value(:remote))
      git_with_identity('fetch', '--tags', @resource.value(:remote))
      update_owner_and_excludes
    end
  end

  private

  # @!visibility private
  def bare_git_config_exists?
    File.exist?(File.join(@resource.value(:path), 'config'))
  end

  # @!visibility private
  def clone_repository(source, path)
    check_force
    args = ['clone']
    if @resource.value(:depth) and @resource.value(:depth).to_i > 0
      args.push('--depth', @resource.value(:depth).to_s)
    end
    if @resource.value(:ensure) == :bare
      args << '--bare'
    end
    if @resource.value(:remote) != 'origin'
      args.push('--origin', @resource.value(:remote))
    end
    if !working_copy_exists?
      args.push(source, path)
      Dir.chdir("/") do
        git_with_identity(*args)
      end
    else
      notice "Repo has already been cloned"
    end
  end

  # @!visibility private
  def check_force
    if path_exists? and not path_empty?
      if @resource.value(:force)
        notice "Removing %s to replace with vcsrepo." % @resource.value(:path)
        destroy
      else
        raise Puppet::Error, "Could not create repository (non-repository at path)"
      end
    end
  end

  # @!visibility private
  def init_repository(path)
    check_force
    if @resource.value(:ensure) == :bare && working_copy_exists?
      convert_working_copy_to_bare
    elsif @resource.value(:ensure) == :present && bare_exists?
      convert_bare_to_working_copy
    else
      # normal init
      FileUtils.mkdir(@resource.value(:path))
      FileUtils.chown(@resource.value(:user), nil, @resource.value(:path)) if @resource.value(:user)
      args = ['init']
      if @resource.value(:ensure) == :bare
        args << '--bare'
      end
      at_path do
        git_with_identity(*args)
      end
    end
  end

  # Convert working copy to bare
  #
  # Moves:
  #   <path>/.git
  # to:
  #   <path>/
  # @!visibility private
  def convert_working_copy_to_bare
    notice "Converting working copy repository to bare repository"
    FileUtils.mv(File.join(@resource.value(:path), '.git'), tempdir)
    FileUtils.rm_rf(@resource.value(:path))
    FileUtils.mv(tempdir, @resource.value(:path))
  end

  # Convert bare to working copy
  #
  # Moves:
  #   <path>/
  # to:
  #   <path>/.git
  # @!visibility private
  def convert_bare_to_working_copy
    notice "Converting bare repository to working copy repository"
    FileUtils.mv(@resource.value(:path), tempdir)
    FileUtils.mkdir(@resource.value(:path))
    FileUtils.mv(tempdir, File.join(@resource.value(:path), '.git'))
    if commits_in?(File.join(@resource.value(:path), '.git'))
      reset('HEAD')
      git_with_identity('checkout', '--force')
      update_owner_and_excludes
    end
  end

  # @!visibility private
  def commits_in?(dot_git)
    Dir.glob(File.join(dot_git, 'objects/info/*'), File::FNM_DOTMATCH) do |e|
      return true unless %w(. ..).include?(File::basename(e))
    end
    false
  end

  # Will checkout a rev/branch/tag using the locally cached versions. Does not
  # handle upstream branch changes
  # @!visibility private
  def checkout(revision = @resource.value(:revision))
    if !local_branch_revision? && remote_branch_revision?
      #non-locally existant branches (perhaps switching to a branch that has never been checked out)
      at_path { git_with_identity('checkout', '--force', '-b', revision, '--track', "#{@resource.value(:remote)}/#{revision}") }
    else
      #tags, locally existant branches (perhaps outdated), and shas
      at_path { git_with_identity('checkout', '--force', revision) }
    end
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
    branch = at_path { branches.grep /(remotes\/)?#{@resource.value(:remote)}\/#{revision}/ }
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
    at_path { git_with_identity('branch', '-a') }.gsub('*', ' ').split(/\n/).map { |line| line.strip }
  end

  # @!visibility private
  def on_branch?
    at_path {
      matches = git_with_identity('branch', '-a').match /\*\s+(.*)/
      matches[1] unless matches[1].match /(\(detached from|\(no branch)/
    }
  end

  # @!visibility private
  def tags
    at_path { git_with_identity('tag', '-l') }.split(/\n/).map { |line| line.strip }
  end

  # @!visibility private
  def set_excludes
    at_path { open('.git/info/exclude', 'w') { |f| @resource.value(:excludes).each { |ex| f.write(ex + "\n") }}}
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
    #TODO Why is create called here anyway?
    create if @resource.value(:force) && working_copy_exists?
    create if !working_copy_exists?

    if branch = on_branch?
      return get_revision("#{@resource.value(:remote)}/#{branch}")
    else
      return get_revision
    end
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
    update_references
    current = at_path { git_with_identity('rev-parse', rev).strip }
    if @resource.value(:revision)
      if tag_revision?
        # git-rev-parse will give you the hash of the tag object itself rather
        # than the commit it points to by default. Using tag^0 will return the
        # actual commit.
        canonical = at_path { git_with_identity('rev-parse', "#{@resource.value(:revision)}^0").strip }
      elsif local_branch_revision?
        canonical = at_path { git_with_identity('rev-parse', @resource.value(:revision)).strip }
      elsif remote_branch_revision?
        canonical = at_path { git_with_identity('rev-parse', "#{@resource.value(:remote)}/#{@resource.value(:revision)}").strip }
      else
        #look for a sha (could match invalid shas)
        canonical = at_path { git_with_identity('rev-parse', '--revs-only', @resource.value(:revision)).strip }
      end
      fail("#{@resource.value(:revision)} is not a local or remote ref") if canonical.nil? or canonical.empty?
      current = @resource.value(:revision) if current == canonical
    end
    return current
  end

  # @!visibility private
  def update_owner_and_excludes
    if @resource.value(:owner) or @resource.value(:group)
      set_ownership
    end
    if @resource.value(:excludes)
      set_excludes
    end
  end

  # @!visibility private
  def git_with_identity(*args)
    if @resource.value(:identity)
      tmp_dir = @resource.value(:tmp_dir) || Dir.tmpdir
      Tempfile.open('git-helper', tmp_dir) do |f|
        f.puts '#!/bin/sh'
        f.puts "exec ssh -oStrictHostKeyChecking=no -oPasswordAuthentication=no -oKbdInteractiveAuthentication=no -oChallengeResponseAuthentication=no -oConnectTimeout=120 -i #{@resource.value(:identity)} $*"
        f.close

        FileUtils.chmod(0755, f.path)
        env_save = ENV['GIT_SSH']
        ENV['GIT_SSH'] = f.path

        ret = git(*args)

        ENV['GIT_SSH'] = env_save

        return ret
      end
    elsif @resource.value(:user) and @resource.value(:user) != Facter['id'].value
      su(@resource.value(:user), '-c', "git #{args.join(' ')}" )
    else
      git(*args)
    end
  end
end
