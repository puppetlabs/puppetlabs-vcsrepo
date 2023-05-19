# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'clones a remote repo' do
  before(:all) do
    create_repo
  end

  after(:all) do
    run_shell("rm -rf #{tmpdir}/testrepo")
    run_shell("rm -rf #{tmpdir}/testrepo_owner")
    run_shell("rm -rf #{tmpdir}/testrepo_mirror_repo")
  end

  context 'with get the current main HEAD' do
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo":
        ensure => present,
        provider => git,
        source => "file://#{tmpdir}/testrepo.git",
      }
    MANIFEST
    it 'clones a repo' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    describe file("#{tmpdir}/testrepo/.git") do
      it { is_expected.to be_directory }
    end

    describe file("#{tmpdir}/testrepo/.git/HEAD") do
      it { is_expected.to contain 'ref: refs/heads/main' }
    end
  end

  context 'with using a https source on github', unless: only_supports_weak_encryption do
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/httpstestrepo":
        ensure => present,
        provider => git,
        source => "https://github.com/puppetlabs/puppetlabs-vcsrepo.git",
      }
    MANIFEST
    it 'clones a repo' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    describe file("#{tmpdir}/httpstestrepo/.git") do
      it { is_expected.to be_directory }
    end

    describe file("#{tmpdir}/httpstestrepo/.git/HEAD") do
      it { is_expected.to contain 'ref: refs/heads/main' }
    end
  end

  context 'with using a commit SHA' do
    let(:sha) do
      run_shell("git --git-dir=#{tmpdir}/testrepo.git rev-list HEAD | tail -1").stdout.chomp
    end

    after(:all) do
      run_shell("rm -rf #{tmpdir}/testrepo_sha")
    end

    it 'clones a repo' do
      pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo_sha":
        ensure => present,
        provider => git,
        source => "file://#{tmpdir}/testrepo.git",
        revision => "#{sha}",
      }
      MANIFEST
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    describe file("#{tmpdir}/testrepo_sha/.git") do
      it { is_expected.to be_directory }
    end

    describe file("#{tmpdir}/testrepo_sha/.git/HEAD") do
      it { is_expected.to contain sha }
    end
  end

  context 'with using a tag' do
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo_tag":
        ensure => present,
        provider => git,
        source => "file://#{tmpdir}/testrepo.git",
        revision => '0.0.2',
      }
    MANIFEST
    it 'clones a repo' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    describe file("#{tmpdir}/testrepo_tag/.git") do
      it { is_expected.to be_directory }
    end

    it 'has the tag as the HEAD' do
      run_shell("git --git-dir=#{tmpdir}/testrepo_tag/.git name-rev HEAD | grep '0.0.2'")
    end
  end

  context 'with using a branch name' do
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo_branch":
        ensure => present,
        provider => git,
        source => "file://#{tmpdir}/testrepo.git",
        revision => 'a_branch',
      }
    MANIFEST
    it 'clones a repo' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    describe file("#{tmpdir}/testrepo_branch/.git") do
      it { is_expected.to be_directory }
    end

    describe file("#{tmpdir}/testrepo_branch/.git/HEAD") do
      it { is_expected.to contain 'ref: refs/heads/a_branch' }
    end
  end

  context 'with ensure latest with branch specified' do
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo_latest":
        ensure => latest,
        provider => git,
        source => "file://#{tmpdir}/testrepo.git",
        revision => 'a_branch',
      }
    MANIFEST
    it 'clones a repo' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    it 'verifies the HEAD commit SHA on remote and local match' do
      remote_commit = run_shell("git ls-remote file://#{tmpdir}/testrepo_latest HEAD | head -1").stdout
      local_commit = run_shell("git --git-dir=#{tmpdir}/testrepo_latest/.git rev-parse HEAD").stdout.chomp
      expect(remote_commit).to include(local_commit)
    end
  end

  context 'with ensure latest with branch unspecified' do
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo_latest":
        ensure => latest,
        provider => git,
        source => "file://#{tmpdir}/testrepo.git",
      }
    MANIFEST
    it 'clones a repo' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    it 'verifies the HEAD commit SHA on remote and local match' do
      remote_commit = run_shell("git ls-remote file://#{tmpdir}/testrepo_latest HEAD | head -1").stdout
      local_commit = run_shell("git --git-dir=#{tmpdir}/testrepo_latest/.git rev-parse HEAD").stdout.chomp
      expect(remote_commit).to include(local_commit)
    end
  end

  context 'with with shallow clone' do
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo_shallow":
        ensure => present,
        provider => git,
        source => "file://#{tmpdir}/testrepo.git",
        depth => '1',
      }
    MANIFEST
    it 'does a shallow clone' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    describe file("#{tmpdir}/testrepo_shallow/.git/shallow") do
      it { is_expected.to be_file }
    end
  end

  context 'with path is not empty and not a repository' do
    before(:all) do
      run_shell("mkdir #{tmpdir}/not_a_repo", acceptable_exit_codes: [0, 1])
      run_shell("touch #{tmpdir}/not_a_repo/file1.txt", acceptable_exit_codes: [0, 1])
    end

    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/not_a_repo":
        ensure => present,
        provider => git
        source => "file://#{tmpdir}/testrepo.git",
      }
    MANIFEST
    it 'raises an exception' do
      apply_manifest(pp, expect_failures: true)
    end
  end

  context 'with with an owner' do
    pp = <<-MANIFEST
    user { 'vagrant':
      ensure => present,
    }
    MANIFEST

    apply_manifest(pp, catch_failures: true)
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo_owner":
        ensure => present,
        provider => git,
        source => "file://#{tmpdir}/testrepo.git",
        owner => 'vagrant',
        safe_directory => true,
      }
    MANIFEST
    it 'clones a repo' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    describe file("#{tmpdir}/testrepo_owner") do
      it { is_expected.to be_directory }
      it { is_expected.to be_owned_by 'vagrant' }
    end

    describe file('/etc/gitconfig') do
      subject { super().content }

      it { is_expected.to match %r{directory = /tmp/vcsrepo/testrepo_owner} }
    end
  end

  context 'with with a group' do
    pp = <<-MANIFEST
    group { 'vagrant':
      ensure => present,
    }
    MANIFEST

    apply_manifest(pp, catch_failures: true)

    pp = <<-MANIFEST
      vcsrepo { "/#{tmpdir}/testrepo_group":
        ensure => present,
        provider => git,
        source => "file://#{tmpdir}/testrepo.git",
        group => 'vagrant',
      }
    MANIFEST
    it 'clones a repo' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    describe file("#{tmpdir}/testrepo_group") do
      it { is_expected.to be_directory }
      it { is_expected.to be_grouped_into 'vagrant' }
    end
  end

  context 'with with excludes' do
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo_excludes":
        ensure => present,
        provider => git,
        source => "file://#{tmpdir}/testrepo.git",
        excludes => ['exclude1.txt', 'exclude2.txt'],
      }
    MANIFEST
    it 'clones a repo' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    describe file("#{tmpdir}/testrepo_excludes/.git/info/exclude") do
      subject { super().content }

      it { is_expected.to match %r{exclude1.txt} }
    end

    describe file("#{tmpdir}/testrepo_excludes/.git/info/exclude") do
      subject { super().content }

      it { is_expected.to match %r{exclude2.txt} }
    end
  end

  context 'with with force' do
    before(:all) do
      run_shell("mkdir -p #{tmpdir}/testrepo_force/folder")
      run_shell("touch #{tmpdir}/testrepo_force/temp.txt")
    end

    it 'applies the manifest' do
      pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo_force":
        ensure => present,
        provider => git,
        source => "file://#{tmpdir}/testrepo.git",
        force => true,
      }
      MANIFEST

      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    describe file("#{tmpdir}/testrepo_force/folder") do
      it { is_expected.not_to be_directory }
    end

    describe file("#{tmpdir}/testrepo_force/temp.txt") do
      it { is_expected.not_to be_file }
    end

    describe file("#{tmpdir}/testrepo_force/.git") do
      it { is_expected.to be_directory }
    end

    context 'with and noop' do
      before(:all) do
        run_shell("mkdir #{tmpdir}/testrepo_already_exists")
        run_shell("cd #{tmpdir}/testrepo_already_exists && git init")
        run_shell("cd #{tmpdir}/testrepo_already_exists && touch a && git add a && git commit -m 'a'")
      end

      after(:all) do
        run_shell("rm -rf #{tmpdir}/testrepo_already_exists")
      end

      pp = <<-MANIFEST
        vcsrepo { "#{tmpdir}/testrepo_already_exists":
          ensure   => present,
          source   => "file://#{tmpdir}/testrepo.git",
          provider => git,
          force    => true,
          noop     => true,
        }
      MANIFEST
      it 'applies the manifest' do
        apply_manifest(pp, catch_changes: true)
      end
    end
  end

  context 'with as a user' do
    before(:all) do
      run_shell("chmod 707 #{tmpdir}")
      pp = <<-MANIFEST
      group { 'testuser':
        ensure => present,
      }
      user { 'testuser':
        ensure => present,
        groups => 'testuser',
      }
      MANIFEST

      apply_manifest(pp, catch_failures: true)
    end

    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo_user":
        ensure => present,
        provider => git,
        source => "file://#{tmpdir}/testrepo.git",
        user => 'testuser',
      }
    MANIFEST
    after(:all) do
      pp = 'user { "testuser": ensure => absent }'
      apply_manifest(pp, catch_failures: true)
    end

    it 'applies the manifest' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    describe file("#{tmpdir}/testrepo_user") do
      it { is_expected.to be_directory }
      it { is_expected.to be_owned_by 'testuser' }
    end

    describe file("#{tmpdir}/testrepo_user") do
      it { is_expected.to be_directory }
      it { is_expected.to be_grouped_into 'testuser' }
    end
  end

  context 'with non-origin remote name' do
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo_remote":
        ensure => present,
        provider => git,
        source => "file://#{tmpdir}/testrepo.git",
        remote => 'testorigin',
      }
    MANIFEST
    it 'applies the manifest' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    it 'remote name is "testorigin"' do
      run_shell("git --git-dir=#{tmpdir}/testrepo_remote/.git remote | grep 'testorigin'")
    end
  end

  context 'with as a user with ssh - includes special characters' do
    before(:all) do
      # create user
      pp = <<-MANIFEST
      group { 'testuser-ssh':
        ensure => present,
      }
      user { 'testuser-ssh':
        ensure => present,
        groups => 'testuser-ssh',
        managehome => true,
      }
      file { '/home/testuser-ssh/.ssh':
        ensure => absent,
        recurse => true,
        force => true,
      }
      MANIFEST
      apply_manifest(pp, catch_failures: true)

      # create ssh keys
      run_shell('mkdir -p /home/testuser-ssh/.ssh')
      run_shell('ssh-keygen -q -t rsa -f /home/testuser-ssh/.ssh/id_rsa -N ""')

      # add localhost to known_hosts
      run_shell('rm /home/testuser-ssh/.ssh/known_hosts', expect_failures: true)
      run_shell('ssh-keyscan localhost >> /home/testuser-ssh/.ssh/known_hosts')

      # copy public key to authorized_keys
      run_shell('cat /home/testuser-ssh/.ssh/id_rsa.pub > /home/testuser-ssh/.ssh/authorized_keys')
      run_shell('echo -e "Host localhost\n\tStrictHostKeyChecking no\n" > /home/testuser-ssh/.ssh/config')
      run_shell('chown -R testuser-ssh:testuser-ssh /home/testuser-ssh/.ssh')
      run_shell('rm -rf /var/run/nologin')
    end

    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo_user_ssh":
        ensure => present,
        provider => git,
        source => "git+ssh://testuser-ssh@localhost#{tmpdir}/testrepo.git",
        user => 'testuser-ssh',
      }
    MANIFEST
    after(:all) do
      pp = <<-MANIFEST
      user { 'testuser-ssh':
        ensure => absent,
        managehome => true,
      }
      MANIFEST
      sleep 10
      apply_manifest(pp, catch_failures: true)
    end

    it 'applies the manifest' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end
  end

  context 'with using an identity file' do
    before(:all) do
      # create user
      pp = <<-MANIFEST
      group { 'testuser-ssh':
        ensure => present,
      }
      user { 'testuser-ssh':
        ensure => present,
        groups => 'testuser-ssh',
        managehome => true,
      }
      MANIFEST
      apply_manifest(pp, catch_failures: true)

      # create ssh keys
      run_shell('mkdir -p /home/testuser-ssh/.ssh')
      run_shell('ssh-keygen -q -t rsa -f /home/testuser-ssh/.ssh/id_rsa -N ""')

      # add localhost to known_hosts
      run_shell('ssh-keyscan localhost > /home/testuser-ssh/.ssh/known_hosts')

      # copy public key to authorized_keys
      run_shell('cat /home/testuser-ssh/.ssh/id_rsa.pub > /home/testuser-ssh/.ssh/authorized_keys')
      run_shell('chown -R testuser-ssh:testuser-ssh /home/testuser-ssh/.ssh')
      run_shell('rm -rf /var/run/nologin')
    end

    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo_user_ssh_id":
        ensure => present,
        provider => git,
        source => "testuser-ssh@localhost:#{tmpdir}/testrepo.git",
        identity => '/home/testuser-ssh/.ssh/id_rsa',
        user => 'testuser-ssh',
      }
    MANIFEST
    it 'applies the manifest' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end
  end

  context 'with bare repo' do
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo_bare_repo":
        ensure => bare,
        provider => git,
        source => "file://#{tmpdir}/testrepo.git",
      }
    MANIFEST
    it 'creates a bare repo' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    describe file("#{tmpdir}/testrepo_bare_repo/config") do
      it { is_expected.to contain 'bare = true' }
    end

    describe file("#{tmpdir}/testrepo_bare_repo/.git") do
      it { is_expected.not_to be_directory }
    end

    describe file("#{tmpdir}/testrepo_bare_repo/HEAD") do
      it { is_expected.to contain 'ref: refs/heads/main' }
    end
  end

  context 'with mirror repo' do
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo_mirror_repo":
        ensure => mirror,
        provider => git,
        source => "file://#{tmpdir}/testrepo.git",
      }
    MANIFEST
    it 'creates a mirror repo' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    describe file("#{tmpdir}/testrepo_mirror_repo/config") do
      it { is_expected.to contain 'bare = true' }
      it { is_expected.to contain 'mirror = true' }
    end

    describe file("#{tmpdir}/testrepo_mirror_repo/.git") do
      it { is_expected.not_to be_directory }
    end

    describe file("#{tmpdir}/testrepo_mirror_repo/HEAD") do
      it { is_expected.to contain 'ref: refs/heads/main' }
    end
  end

  context 'with skip hooks' do
    pp_template = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo_skip_hooks":
        ensure => present,
        provider => git,
        source => "file://#{tmpdir}/testrepo.git",
        skip_hooks => %s,
      }
    MANIFEST

    context 'when true' do
      pp = pp_template % :true

      it 'clones a repo' do
        # Run it twice and test for idempotency
        idempotent_apply(pp)
      end

      describe file("#{tmpdir}/testrepo_skip_hooks/.git/config") do
        it { is_expected.to contain 'hooksPath = /dev/null' }
      end
    end

    context 'when false' do
      pp = pp_template % :false

      it 'clones a repo' do
        # Run it twice and test for idempotency
        idempotent_apply(pp)
      end

      describe file("#{tmpdir}/testrepo_skip_hooks/.git/config") do
        it { is_expected.not_to contain 'hooksPath' }
      end
    end
  end

  context 'with umask' do
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo_umask":
        ensure => present,
        provider => git,
        source => "file://#{tmpdir}/testrepo.git",
        umask => '0002',
      }
    MANIFEST
    it 'clones a repo' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    describe file("#{tmpdir}/testrepo_umask/.git/HEAD") do
      # NOTE: '0664' is not supported by 'be_mode'; this must be three digits
      # unless the first octet is non-zero.
      it { is_expected.to be_mode '664' }
    end
  end
end
