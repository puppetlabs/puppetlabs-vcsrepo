# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'clones a remote repo', unless: only_supports_weak_encryption do
  before(:all) do
    File.expand_path(File.join(File.dirname(__FILE__), '..'))
    run_shell("mkdir -p #{tmpdir}") # win test
  end

  after(:all) do
    run_shell("rm -rf #{tmpdir}/vcsrepo")
  end

  context 'with clone with single remote' do
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/vcsrepo":
          ensure   => present,
          provider => git,
          source   => "https://github.com/puppetlabs/puppetlabs-vcsrepo.git",
      }
    MANIFEST
    after(:all) do
      run_shell("rm -rf #{tmpdir}/vcsrepo")
    end

    it 'clones from default remote' do
      apply_manifest(pp, catch_failures: true)
    end

    it 'git config output should contain the remote' do
      run_shell("/usr/bin/git config -l -f #{tmpdir}/vcsrepo/.git/config") do |r|
        expect(r.stdout).to match(%r{remote.origin.url=https://github.com/puppetlabs/puppetlabs-vcsrepo.git})
      end
    end
  end

  context 'with clone with multiple remotes' do
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/vcsrepo":
          ensure   => present,
          provider => git,
          source   => {"origin" => "https://github.com/puppetlabs/puppetlabs-vcsrepo.git", "test1" => "https://github.com/puppetlabs/puppetlabs-vcsrepo.git"},
      }
    MANIFEST
    after(:all) do
      run_shell("rm -rf #{tmpdir}/vcsrepo")
    end

    it 'clones from default remote and adds 2 remotes to config file' do
      idempotent_apply(pp)
    end

    it 'git config output should contain the remotes - origin' do
      run_shell("/usr/bin/git config -l -f #{tmpdir}/vcsrepo/.git/config") do |r|
        expect(r.stdout).to match(%r{remote.origin.url=https://github.com/puppetlabs/puppetlabs-vcsrepo.git})
      end
    end

    it 'git config output should contain the remotes - test1' do
      run_shell("/usr/bin/git config -l -f #{tmpdir}/vcsrepo/.git/config") do |r|
        expect(r.stdout).to match(%r{remote.test1.url=https://github.com/puppetlabs/puppetlabs-vcsrepo.git})
      end
    end
  end
end
