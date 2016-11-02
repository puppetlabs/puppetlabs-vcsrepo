require 'spec_helper_acceptance'

tmpdir = default.tmpdir('vcsrepo')

describe 'subversion tests' do
  before(:each) do
    shell("mkdir -p #{tmpdir}") # win test
  end

  context "plain checkout" do
    it "can checkout svn" do
      pp = <<-EOS
      vcsrepo { "#{tmpdir}/svnrepo":
        ensure   => present,
        provider => svn,
        source   => "http://svn.apache.org/repos/asf/subversion/svn-logos",
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)

    end

    describe file("#{tmpdir}/svnrepo/.svn") do
      it { is_expected.to be_directory }
    end
    describe file("#{tmpdir}/svnrepo/images/tyrus-svn2.png") do
      its(:md5sum) { should eq '6b20cbc4a793913190d1548faad1ae80' }
    end

    after(:all) do
      shell("rm -rf #{tmpdir}/svnrepo")
    end

  end

  context "handles revisions" do
    it "can checkout a specific revision of svn" do
      pp = <<-EOS
      vcsrepo { "#{tmpdir}/svnrepo":
        ensure   => present,
        provider => svn,
        source   => "http://svn.apache.org/repos/asf/subversion/developer-resources",
        revision => 1000000,
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)

    end

    describe file("#{tmpdir}/svnrepo/.svn") do
      it { is_expected.to be_directory }
    end
    describe command("svn info #{tmpdir}/svnrepo") do
      its(:stdout) { should match( /.*Revision: 1000000.*/ ) }
    end
    describe file("#{tmpdir}/svnrepo/difftools/README") do
      its(:md5sum) { should eq '540241e9d5d4740d0ef3d27c3074cf93' }
    end

  end

  context "handles revisions" do
    it "can switch revisions" do
      pp = <<-EOS
      vcsrepo { "#{tmpdir}/svnrepo":
        ensure   => present,
        provider => svn,
        source   => "http://svn.apache.org/repos/asf/subversion/developer-resources",
        revision => 1700000,
      }
      EOS

      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)

    end

    describe file("#{tmpdir}/svnrepo/.svn") do
      it { is_expected.to be_directory }
    end
    describe command("svn info #{tmpdir}/svnrepo") do
      its(:stdout) { should match( /.*Revision: 1700000.*/ ) }
    end

    after(:all) do
      shell("rm -rf #{tmpdir}/svnrepo")
    end

  end

  context "switching sources" do
    it "can checkout tag=1.9.0" do
      pp = <<-EOS
      vcsrepo { "#{tmpdir}/svnrepo":
        ensure   => present,
        provider => svn,
        source   => "http://svn.apache.org/repos/asf/subversion/tags/1.9.0",
      }
      EOS
      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end
    describe file("#{tmpdir}/svnrepo/.svn") do
      it { is_expected.to be_directory }
    end
    describe file("#{tmpdir}/svnrepo/STATUS") do
      its(:md5sum) { should eq '286708a30aea43d78bc2b11f3ac57fff' }
    end
  end

  context "switching sources" do
    it "can switch to tag=1.9.4" do
      pp = <<-EOS
      vcsrepo { "#{tmpdir}/svnrepo":
        ensure   => present,
        provider => svn,
        source   => "http://svn.apache.org/repos/asf/subversion/tags/1.9.4",
      }
      EOS
      # Run it twice and test for idempotency
      apply_manifest(pp, :catch_failures => true)
      apply_manifest(pp, :catch_changes => true)
    end

    describe file("#{tmpdir}/svnrepo/.svn") do
      it { is_expected.to be_directory }
    end
    describe file("#{tmpdir}/svnrepo/STATUS") do
      its(:md5sum) { should eq '7f072a1c0e2ba37ca058f65e554de95e' }
    end

  end

end

