# frozen_string_literal: true

require 'singleton'

class LitmusHelper
  include Singleton
  include PuppetLitmus
end

def tmpdir
  '/tmp/vcsrepo'
end

def project_root
  File.expand_path(File.join(File.dirname(__FILE__)))
end

def create_repo
  LitmusHelper.instance.run_shell("rm -rf #{tmpdir}")
  LitmusHelper.instance.run_shell("mkdir -p #{tmpdir}")
  LitmusHelper.instance.bolt_upload_file("#{project_root}/acceptance/files/create_git_repo.sh", "#{tmpdir}/create_git_repo.sh")
  LitmusHelper.instance.run_shell("cd #{tmpdir} && ./create_git_repo.sh")
end

RSpec.configure do |c|
  # Readable test descriptions
  c.formatter = :documentation

  # Configure all nodes in nodeset
  c.before :suite do
    case os[:family]
    when 'redhat'
      if %r{5}.match?(os[:release][0])
        LitmusHelper.instance.run_shell('which git', expect_failures: true)
        LitmusHelper.instance.run_shell('rpm -ivh http://repository.it4i.cz/mirrors/repoforge/redhat/el5/en/x86_64/rpmforge/RPMS/rpmforge-release-0.5.3-1.el5.rf.x86_64.rpm', expect_failures: true)
        LitmusHelper.instance.run_shell('yum install -y git')
      end
      pp = <<-PP
      package { 'git': ensure => present, }
      package { 'subversion': ensure => present, }
      PP
      LitmusHelper.instance.apply_manifest(pp)
    when %r{(ubuntu|[dD]ebian|sles)}
      pp = <<-PP
      package { 'git-core': ensure => present, }
      package { 'subversion': ensure => present, }
      PP
      LitmusHelper.instance.apply_manifest(pp)
    else
      unless run_bolt_task('package', 'action' => 'status', 'name' => 'git')
        puts 'Git package is required for this module'
        exit
      end
      unless run_bolt_task('package', 'action' => 'status', 'name' => 'subversion')
        puts 'Subversion package is required for this module'
        exit
      end
    end
    LitmusHelper.instance.run_shell('git config --global user.email "root@localhost"')
    LitmusHelper.instance.run_shell('git config --global user.name "root"')
  end
end

# git with 3.18 changes the maximum enabled TLS protocol version, older OSes will fail these tests
def only_supports_weak_encryption
  return_val = ((os[:family] == 'redhat' && os[:release].start_with?('5', '6')) ||
  (os[:family] == 'sles' && os[:release].start_with?('11')))
  return_val
end
