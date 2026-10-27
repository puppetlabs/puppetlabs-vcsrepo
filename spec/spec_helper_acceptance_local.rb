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
      LitmusHelper.instance.apply_manifest("package { 'epel-release': ensure => present, }") if os[:name] != 'Fedora'
      pp = <<-PP
      package { 'git': ensure => present, }
      package { 'subversion': ensure => present, }
      PP
      LitmusHelper.instance.apply_manifest(pp, catch_failures: true)
    when %r{(ubuntu|[dD]ebian|sles)}
      if os[:family] == 'sles' && os[:release].start_with?('12')
        # The SLES 12 test VMs (GCP BYOS images) have no repos configured and SUSEConnect doesn't work,
        # so git-core and subversion can't be found. Use the openSUSE Leap 42.3 repo, which is built from SLES 12.
        # Leap 42.3 is discontinued and download.opensuse.org redirects it (over plain HTTP for some files), so use the
        # openSUSE archive over HTTPS directly. Its metadata is signed with the openSUSE Project Signing Key
        # (22C0 7BA5 3417 8CD0 2EFE 22AA B88B 2FD4 3DBD C284), imported from the pinned copy in acceptance/files rather
        # than auto-importing whatever key the server sends (the file is the repo's gpg-pubkey-3dbdc284-53674dd4.asc,
        # fingerprint cross-checked on keys.openpgp.org). The key expired in 2024; zypper only warns about that.
        # Temporary: remove once SLES 12 leaves metadata.json or the test images come with registered repos.
        LitmusHelper.instance.bolt_upload_file("#{project_root}/acceptance/files/opensuse-signing-key-3dbdc284.asc", '/tmp/opensuse-signing-key-3dbdc284.asc')
        LitmusHelper.instance.run_shell('rpm --import /tmp/opensuse-signing-key-3dbdc284.asc')
        LitmusHelper.instance.run_shell('zypper lr opensuse-leap-42.3-archive >/dev/null 2>&1 || ' \
                                        'zypper --non-interactive ar --type yast2 https://ftp5.gwdg.de/pub/opensuse/discontinued/distribution/leap/42.3/repo/oss/ opensuse-leap-42.3-archive')
        LitmusHelper.instance.run_shell('zypper --non-interactive refresh opensuse-leap-42.3-archive')
      end
      pp = <<-PP
      package { 'git-core': ensure => present, }
      package { 'subversion': ensure => present, }
      PP
      LitmusHelper.instance.apply_manifest(pp, catch_failures: true)
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
  (os[:family] == 'sles' && os[:release].start_with?('11'))
end
