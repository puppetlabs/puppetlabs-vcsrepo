# frozen_string_literal: true

require 'spec_helper_acceptance'

tmpdir = '/tmp/vcsrepo'

describe 'subversion tests' do
  before(:each) do
    run_shell("mkdir -p #{tmpdir}") # win test
  end

  context 'with plain checkout' do
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/svnrepo":
        ensure   => present,
        provider => svn,
        source   => "http://svn.apache.org/repos/asf/subversion/svn-logos",
      }
    MANIFEST
    it 'can checkout svn' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    describe file("#{tmpdir}/svnrepo/.svn") do
      it { is_expected.to be_directory }
    end
    describe file("#{tmpdir}/svnrepo/images/tyrus-svn2.png") do
      its(:md5sum) { is_expected.to eq '6b20cbc4a793913190d1548faad1ae80' }
    end

    after(:all) do
      run_shell("rm -rf #{tmpdir}/svnrepo")
    end
  end

  context 'with handles revisions' do
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/svnrepo":
        ensure   => present,
        provider => svn,
        source   => "http://svn.apache.org/repos/asf/subversion/developer-resources",
        revision => 1000000,
      }
    MANIFEST
    it 'can checkout a specific revision of svn' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    describe file("#{tmpdir}/svnrepo/.svn") do
      it { is_expected.to be_directory }
    end

    it 'svn info svnrepo' do
      run_shell("svn info #{tmpdir}/svnrepo") do |r|
        expect(r.stdout).to match(%r{.*Revision: 1000000.*})
      end
    end

    describe file("#{tmpdir}/svnrepo/difftools/README") do
      its(:md5sum) { is_expected.to eq '540241e9d5d4740d0ef3d27c3074cf93' }
    end
  end

  context 'with handles revisions' do
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/svnrepo":
        ensure   => present,
        provider => svn,
        source   => "http://svn.apache.org/repos/asf/subversion/developer-resources",
        revision => 1700000,
      }
    MANIFEST
    it 'can switch revisions' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    describe file("#{tmpdir}/svnrepo/.svn") do
      it { is_expected.to be_directory }
    end
    it 'svn info svnrepo' do
      run_shell("svn info #{tmpdir}/svnrepo") do |r|
        expect(r.stdout).to match(%r{.*Revision: 1700000.*})
      end
    end

    after(:all) do
      run_shell("rm -rf #{tmpdir}/svnrepo")
    end
  end

  context 'with switching sources' do
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/svnrepo":
        ensure   => present,
        provider => svn,
        source   => "http://svn.apache.org/repos/asf/subversion/tags/1.9.0",
      }
    MANIFEST
    it 'can checkout tag=1.9.0' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end
    describe file("#{tmpdir}/svnrepo/.svn") do
      it { is_expected.to be_directory }
    end
    describe file("#{tmpdir}/svnrepo/STATUS") do
      its(:md5sum) { is_expected.to eq '286708a30aea43d78bc2b11f3ac57fff' }
    end
  end

  context 'with Sensitive password' do
    pp = <<-MANIFEST
      vcsrepo { 'SVN':
      ensure => latest,
      path => '/tmp/svn',
      provider => svn,
      source => 'http://svn.apache.org/repos/asf/subversion/svn-logos',
      basic_auth_username => 'svn_user',
      basic_auth_password => Sensitive('sensitivePassword'),
    }
    MANIFEST
    it 'can use Sensitive' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end
  end

  context 'with switching sources' do
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/svnrepo":
        ensure   => present,
        provider => svn,
        source   => "http://svn.apache.org/repos/asf/subversion/tags/1.9.4",
      }
    MANIFEST
    it 'can switch to tag=1.9.4' do
      # Run it twice and test for idempotency
      idempotent_apply(pp)
    end

    describe file("#{tmpdir}/svnrepo/.svn") do
      it { is_expected.to be_directory }
    end
    describe file("#{tmpdir}/svnrepo/STATUS") do
      its(:md5sum) { is_expected.to eq '7f072a1c0e2ba37ca058f65e554de95e' }
    end
  end
end
