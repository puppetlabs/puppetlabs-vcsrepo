# frozen_string_literal: true

require 'tmpdir'
require 'digest/md5'
require 'fileutils'

# Abstract
class Puppet::Provider::Vcsrepo < Puppet::Provider
  def check_force
    return unless path_exists? && !path_empty?
    raise Puppet::Error, 'Path %s exists and is not the desired repository.' % @resource.value(:path) unless @resource.value(:force)

    notice 'Removing %s to replace with desired repository.' % @resource.value(:path)
    destroy
  end

  private

  def set_ownership
    owner = @resource.value(:owner) || nil
    group = @resource.value(:group) || nil
    excludes = @resource.value(:excludes) || nil
    if excludes.nil? || excludes.empty?
      FileUtils.chown_R(owner, group, @resource.value(:path))
    else
      FileUtils.chown(owner, group, files)
    end
  end

  def files
    excludes = @resource.value(:excludes)
    path = @resource.value(:path)
    Dir["#{path}/**/*"].reject { |f| excludes.any? { |p| f.start_with?("#{path}/#{p}") } }
  end

  def path_exists?
    File.directory?(@resource.value(:path))
  end

  def path_empty?
    # Path is empty if the only entries are '.' and '..'
    d = Dir.new(@resource.value(:path))
    d.read # should return '.'
    d.read # should return '..'
    d.read.nil?
  end

  # NOTE: We don't rely on Dir.chdir's behavior of automatically returning the
  # value of the last statement -- for easier stubbing.
  def at_path # :nodoc:
    value = nil
    Dir.chdir(@resource.value(:path)) do
      value = yield
    end
    value
  end

  def tempdir
    @tempdir ||= File.join(Dir.tmpdir, "vcsrepo-#{Digest::MD5.hexdigest(@resource.value(:path))}")
  end

  # If the resource has a umask, then run the block with that umask; otherwise,
  # run the block directly.
  def withumask(&block)
    if @resource.value(:umask)
      Puppet::Util.withumask(@resource.value(:umask), &block)
    else
      yield
    end
  end
end
