require File.join(File.dirname(__FILE__), '..', 'vcsrepo')

Puppet::Type.type(:vcsrepo).provide(:svn, :parent => Puppet::Provider::Vcsrepo) do
  desc "Supports Subversion repositories"

  optional_commands :svn      => 'svn',
                    :svnadmin => 'svnadmin'

  defaultfor :svn => :exists
  has_features :filesystem_types, :reference_tracking, :basic_auth, :export, :sparse, :filename

  def create
    if !@resource.value(:source) && !@resource.value(:filename)
      create_repository(@resource.value(:path))
    else
      checkout_repository(@resource.value(:source),
                          @resource.value(:path),
                          @resource.value(:revision))
    end
    update_owner
  end

  def working_copy_exists?
    if File.file?(@resource.value(:path))
      File.directory?(File.join(File.dirname(@resource.value(:path)), '.svn'))
    else
      File.directory?(File.join(@resource.value(:path), '.svn'))
    end
  end

  def exists?
    working_copy_exists?
  end

  def destroy
    FileUtils.rm_rf(@resource.value(:path))
  end

  def latest?
    if revision < latest then
      return false
    else
      return true
    end
  end

  def buildargs
    args = ['--non-interactive']
    if @resource.value(:basic_auth_username) && @resource.value(:basic_auth_password)
      args.push('--username', @resource.value(:basic_auth_username))
      args.push('--password', @resource.value(:basic_auth_password))
      args.push('--no-auth-cache')
      args.push('--trust-server-cert')
    end
    return args
  end

  def latest
    args = buildargs.push('info', '-r', 'HEAD', @resource.value(:path))
    svn(*args)[/^Last Changed Rev:\s+(\d+)/m, 1]
  end

  def revision
    args = buildargs.push('info', @resource.value(:path))
    svn(*args)[/^Last Changed Rev:\s+(\d+)/m, 1]
  end

  def revision=(desired)
    args = buildargs.push('update', '-r', desired, @resource.value(:path))
    svn(*args)
    update_owner
  end

  private

  def checkout_repository(source, path, revision)
    if @resource.value(:export)
      args = buildargs.push('export')
    elsif @resource.value(:sparse)
      args = buildargs.push('checkout')
      args.push('--depth=empty')
    elsif @resource.value(:filename)
      args = buildargs.push('up')
      args.push(@resource.value(:filename))
    else
      args = buildargs.push('checkout')
    end
    if revision
      args.push('-r', revision)
    end
    args.push(source, path)
    svn(*args)
  end

  def create_repository(path)
    args = ['create']
    if @resource.value(:fstype)
      args.push('--fs-type', @resource.value(:fstype))
    end
    args << path
    svnadmin(*args)
  end

  def update_owner
    if @resource.value(:owner) or @resource.value(:group) or @resource.value(:mode)
      set_ownership
    end
  end
end
