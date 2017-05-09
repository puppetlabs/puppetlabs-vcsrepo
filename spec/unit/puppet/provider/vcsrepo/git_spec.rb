require 'spec_helper'

describe Puppet::Type.type(:vcsrepo).provider(:git) do
  def branch_a_list(include_branch = nil?)
    <<branches
end
#{"*  master" unless  include_branch.nil?}
#{"*  " + include_branch unless !include_branch}
   remote/origin/master
   remote/origin/foo

branches
  end
  let(:resource) { Puppet::Type.type(:vcsrepo).new({
    :name     => 'test',
    :ensure   => :present,
    :provider => :git,
    :revision => '2634',
    :source   => 'git@repo',
    :path     => '/tmp/test',
    :force    => false
  })}

  let(:provider) { resource.provider }

  before :each do
    Puppet::Util.stubs(:which).with('git').returns('/usr/bin/git')
  end

  context 'creating' do
    context "with an ensure of present" do

      context "with a revision that is a remote branch" do
        it "should execute 'git clone' and 'git checkout -b'" do
          resource[:revision] = 'only/remote'
          Dir.expects(:chdir).with('/').at_least_once.yields
          Dir.expects(:chdir).with('/tmp/test').at_least_once.yields
          provider.expects(:git).with('clone', resource.value(:source), resource.value(:path))
          provider.expects(:update_submodules)
          provider.expects(:update_remote_url).with("origin", resource.value(:source)).returns false
          provider.expects(:git).with('branch', '-a').returns(branch_a_list(resource.value(:revision)))
          provider.expects(:git).with('checkout', '--force', resource.value(:revision))
          provider.create
        end
      end

      context "with a remote not named 'origin'" do
        it "should execute 'git clone --origin not_origin" do
          resource[:remote] = 'not_origin'
          Dir.expects(:chdir).with('/').at_least_once.yields
          Dir.expects(:chdir).with('/tmp/test').at_least_once.yields
          provider.expects(:git).with('clone', '--origin', 'not_origin', resource.value(:source), resource.value(:path))
          provider.expects(:update_submodules)
          provider.expects(:update_remote_url).with("not_origin", resource.value(:source)).returns false
          provider.expects(:git).with('branch', '-a').returns(branch_a_list(resource.value(:revision)))
          provider.expects(:git).with('checkout', '--force', resource.value(:revision))
          provider.create
        end
      end

      context "with shallow clone enable" do
        it "should execute 'git clone --depth 1'" do
          resource[:revision] = 'only/remote'
          resource[:depth] = 1
          Dir.expects(:chdir).with('/').at_least_once.yields
          Dir.expects(:chdir).with('/tmp/test').at_least_once.yields
          provider.expects(:git).with('clone', '--depth', '1', '--branch', resource.value(:revision),resource.value(:source), resource.value(:path))
          provider.expects(:update_submodules)
          provider.expects(:update_remote_url).with("origin", resource.value(:source)).returns false
          provider.expects(:git).with('branch', '-a').returns(branch_a_list(resource.value(:revision)))
          provider.expects(:git).with('checkout', '--force', resource.value(:revision))
          provider.create
        end
      end

      context "with a revision that is not a remote branch" do
        it "should execute 'git clone' and 'git reset --hard'" do
          resource[:revision] = 'a-commit-or-tag'
          Dir.expects(:chdir).with('/').at_least_once.yields
          Dir.expects(:chdir).with('/tmp/test').at_least_once.yields
          provider.expects(:git).with('clone', resource.value(:source), resource.value(:path))
          provider.expects(:update_submodules)
          provider.expects(:update_remote_url).with("origin", resource.value(:source)).returns false
          provider.expects(:git).with('branch', '-a').returns(branch_a_list(resource.value(:revision)))
          provider.expects(:git).with('checkout', '--force', resource.value(:revision))
          provider.create
        end

        it "should execute 'git clone' and submodule commands" do
          resource.delete(:revision)
          provider.expects(:git).with('clone', resource.value(:source), resource.value(:path))
          provider.expects(:update_submodules)
          provider.expects(:update_remotes)
          provider.create
        end
      end

      context "when a source is not given" do
        context "when the path does not exist" do
          it "should execute 'git init'" do
            resource[:ensure] = :present
            resource.delete(:source)
            expects_mkdir
            expects_chdir
            expects_directory?(false)
            provider.expects(:git).with('init')
            provider.create
          end
        end

        context "when the path is not empty and not a repository" do
          it "should raise an exception" do
            provider.expects(:path_exists?).returns(true)
            provider.expects(:path_empty?).returns(false)
            expect { provider.create }.to raise_error(Puppet::Error)
          end
        end
      end

    end

    context "with an ensure of bare" do
      context "with revision" do
        it "should raise an error" do
          resource[:ensure] = :bare
          expect { provider.create }.to raise_error Puppet::Error, /cannot set a revision.+bare/i
        end
      end
      context "without revision" do
        it "should just execute 'git clone --bare'" do
          resource[:ensure] = :bare
          resource.delete(:revision)
          provider.expects(:git).with('clone', '--bare', resource.value(:source), resource.value(:path))
          provider.expects(:update_remotes)
          provider.create
        end
      end
      context "without a source" do
        it "should execute 'git init --bare'" do
          resource[:ensure] = :bare
          resource.delete(:source)
          resource.delete(:revision)
          File.expects(:directory?).with(File.join(resource.value(:path), '.git'))
          expects_chdir
          expects_mkdir
          expects_directory?(false)
          provider.expects(:git).with('init', '--bare')
          provider.create
        end
      end

    end

    context "with an ensure of mirror" do

      context "with revision" do
        it "should raise an error" do
          resource[:ensure] = :mirror
          expect { provider.create }.to raise_error Puppet::Error, /cannot set a revision.+bare/i
        end
      end
      context "without revision" do
        it "should just execute 'git clone --mirror'" do
          resource[:ensure] = :mirror
          resource.delete(:revision)
          Dir.expects(:chdir).with('/').at_least_once.yields
          provider.expects(:git).with('clone', '--mirror', resource.value(:source), resource.value(:path))
          provider.expects(:update_remotes)
          provider.create
        end
      end

      context "without a source" do
        it "should raise an exeption" do
          resource[:ensure] = :mirror
          resource.delete(:source)
          resource.delete(:revision)
          expect { provider.create }.to raise_error Puppet::Error, /cannot init repository with mirror.+try bare/i
        end
      end

    end


    context "with an ensure of mirror" do

      context "with multiple remotes" do
        it "should execute 'git clone --mirror' and set all remotes to mirror" do
          resource[:ensure] = :mirror
          resource[:source] = {"origin" => "git://git@foo.com/bar.git", "other" => "git://git@foo.com/baz.git"}
          resource.delete(:revision)
          Dir.expects(:chdir).with('/').at_least_once.yields
          provider.expects(:git).with('clone', '--mirror', resource.value(:source)['origin'], resource.value(:path))
          provider.expects(:update_remotes)
          expects_chdir
          provider.expects(:git).with('config', 'remote.origin.mirror', 'true')
          provider.expects(:git).with('config', 'remote.other.mirror', 'true')
          provider.create
        end
      end

    end

    context "when the path is a working copy repository" do
      it "should clone overtop it using force" do
        resource[:force] = true
        Dir.expects(:chdir).with('/').at_least_once.yields
        Dir.expects(:chdir).with('/tmp/test').at_least_once.yields
        provider.expects(:path_exists?).returns(true)
        provider.expects(:path_empty?).returns(false)
        provider.destroy
        provider.expects(:git).with('clone',resource.value(:source), resource.value(:path))
        provider.expects(:update_submodules)
        provider.expects(:update_remote_url).with("origin", resource.value(:source)).returns false
        provider.expects(:git).with('branch', '-a').returns(branch_a_list(resource.value(:revision)))
        provider.expects(:git).with('checkout', '--force', resource.value(:revision))
        provider.create
      end
    end

    context "when the path is not empty and not a repository" do
      it "should raise an exception" do
        provider.expects(:path_exists?).returns(true)
        provider.expects(:path_empty?).returns(false)
        ## this test can never succeed due to logic in
        ##  create/check_force
        # provider.expects(:working_copy_exists?).returns(false)
        expect { provider.create }.to raise_error(Puppet::Error)
      end
    end
  end

  context "converting repo type" do

    context "from working copy to bare" do
      it "should convert the repo" do
        resource[:ensure] = :bare
        provider.expects(:working_copy_exists?).returns(true)
        provider.expects(:bare_exists?).returns(false)
        FileUtils.expects(:mv).returns(true)
        FileUtils.expects(:rm_rf).returns(true)
        FileUtils.expects(:mv).returns(true)
        expects_chdir
        provider.expects(:git).with('config', '--local', '--bool', 'core.bare', 'true')
        provider.instance_eval { convert_working_copy_to_bare }
      end
    end

    context "from working copy to mirror" do
      it "should convert the repo" do
        resource[:ensure] = :mirror
        provider.expects(:working_copy_exists?).returns(true)
        provider.expects(:bare_exists?).returns(false)
        FileUtils.expects(:mv).returns(true)
        FileUtils.expects(:rm_rf).returns(true)
        FileUtils.expects(:mv).returns(true)
        expects_chdir
        provider.expects(:git).with('config', '--local', '--bool', 'core.bare', 'true')
        provider.expects(:git).with('config', 'remote.origin.mirror', 'true')
        provider.instance_eval { convert_working_copy_to_bare }
      end
    end

    context "from bare copy to working copy" do
      it "should convert the repo" do
        FileUtils.expects(:mv).returns(true)
        FileUtils.expects(:mkdir).returns(true)
        FileUtils.expects(:mv).returns(true)
        expects_chdir
        provider.expects(:has_commits?).returns(true)
        # If you forget to stub these out you lose 3 hours of rspec work.
        provider.expects(:git).
          with('config', '--local', '--bool', 'core.bare', 'false').returns(true)
        provider.expects(:reset).with('HEAD').returns(true)
        provider.expects(:git_with_identity).with('checkout', '--force').returns(true)
        provider.expects(:update_owner_and_excludes).returns(true)
        provider.expects(:mirror?).returns(false)
        provider.instance_eval { convert_bare_to_working_copy }
      end
    end

    context "from mirror to working copy" do
      it "should convert the repo" do
        FileUtils.expects(:mv).returns(true)
        FileUtils.expects(:mkdir).returns(true)
        FileUtils.expects(:mv).returns(true)
        expects_chdir
        provider.expects(:has_commits?).returns(true)
        provider.expects(:git).
          with('config', '--local', '--bool', 'core.bare', 'false').returns(true)
        provider.expects(:reset).with('HEAD').returns(true)
        provider.expects(:git_with_identity).with('checkout', '--force').returns(true)
        provider.expects(:update_owner_and_excludes).returns(true)
        provider.expects(:git).with('config', '--unset', 'remote.origin.mirror')
        provider.expects(:mirror?).returns(true)
        provider.instance_eval { convert_bare_to_working_copy }
      end
    end

  end

  context 'destroying' do
    it "it should remove the directory" do
      expects_rm_rf
      provider.destroy
    end
  end

  context "checking the revision property" do
    before do
      expects_chdir('/tmp/test')
      resource[:revision] = 'currentsha'
      resource[:source] = 'http://example.com'
      provider.stubs(:git).with('config', 'remote.origin.url').returns('')
      provider.stubs(:git).with('fetch', 'origin') # FIXME
      provider.stubs(:git).with('fetch', '--tags', 'origin')
      provider.stubs(:git).with('rev-parse', 'HEAD').returns('currentsha')
      provider.stubs(:git).with('branch', '-a').returns(branch_a_list(resource.value(:revision)))
      provider.stubs(:git).with('tag', '-l').returns("Hello")
    end

    context "when its SHA is not different than the current SHA" do
      it "should return the ref" do
        provider.expects(:git).with('rev-parse', resource.value(:revision)).returns('currentsha')
        provider.expects(:update_references)
        expect(provider.revision).to eq(resource.value(:revision))
      end
    end

    context "when its SHA is different than the current SHA" do
      it "should return the current SHA" do
        provider.expects(:git).with('rev-parse', resource.value(:revision)).returns('othersha')
        provider.expects(:update_references)
        expect(provider.revision).to eq(resource.value(:revision))
      end
    end

    context "when its a ref to a remote head" do
      it "should return the revision" do
        provider.stubs(:git).with('branch', '-a').returns("  remotes/origin/#{resource.value(:revision)}")
        provider.expects(:git).with('rev-parse', "origin/#{resource.value(:revision)}").returns("newsha")
        provider.expects(:update_references)
        expect(provider.revision).to eq(resource.value(:revision))
      end
    end

    context "when its a ref to non existant remote head" do
      it "should fail" do
        provider.expects(:git).with('branch', '-a').returns(branch_a_list)
        provider.expects(:git).with('rev-parse', '--revs-only', resource.value(:revision)).returns('')
        provider.expects(:update_references)
        expect { provider.revision }.to raise_error(Puppet::Error, /not a local or remote ref$/)
      end
    end

    context "when there's no source" do
      it 'should return the revision' do
        resource.delete(:source)
        provider.expects(:git).with('status')
        provider.expects(:git).with('rev-parse', resource.value(:revision)).returns('currentsha')
        expect(provider.revision).to eq(resource.value(:revision))
      end
    end
  end

  context "setting the revision property" do
    before do
      expects_chdir
    end
    context "when it's an existing local branch" do
      it "should use 'git fetch' and 'git reset'" do
        resource[:revision] = 'feature/foo'
        provider.expects(:update_submodules)
        provider.expects(:git).with('branch', '-a').at_least_once.returns(branch_a_list(resource.value(:revision)))
        provider.expects(:git).with('checkout', '--force', resource.value(:revision))
        provider.expects(:git).with('reset', '--hard',  "origin/#{resource.value(:revision)}")
        provider.revision = resource.value(:revision)
      end
    end
    context "when it's a remote branch" do
      it "should use 'git fetch' and 'git reset'" do
        resource[:revision] = 'only/remote'
        provider.expects(:update_submodules)
        provider.expects(:git).with('branch', '-a').at_least_once.returns(resource.value(:revision))
        provider.expects(:git).with('checkout', '--force', resource.value(:revision))
        provider.expects(:git).with('reset', '--hard',  "origin/#{resource.value(:revision)}")
        provider.revision = resource.value(:revision)
      end
    end
    context "when it's a commit or tag" do
      it "should use 'git fetch' and 'git reset'" do
        resource[:revision] = 'a-commit-or-tag'
        provider.expects(:git).with('branch', '-a').at_least_once.returns(fixture(:git_branch_a))
        provider.expects(:git).with('checkout', '--force', resource.value(:revision))
        provider.expects(:git).with('branch', '-a').returns(fixture(:git_branch_a))
        provider.expects(:git).with('branch', '-a').returns(fixture(:git_branch_a))
        provider.expects(:git).with('submodule', 'update', '--init', '--recursive')
        provider.revision = resource.value(:revision)
      end
    end
  end

  context "checking the source property" do
    before do
      expects_chdir('/tmp/test')
      provider.stubs(:git).with('config', 'remote.origin.url').returns('')
      provider.stubs(:git).with('fetch', 'origin') # FIXME
      provider.stubs(:git).with('fetch', '--tags', 'origin')
      provider.stubs(:git).with('rev-parse', 'HEAD').returns('currentsha')
      provider.stubs(:git).with('branch', '-a').returns(branch_a_list(resource.value(:revision)))
      provider.stubs(:git).with('tag', '-l').returns("Hello")
    end

    context "when there's a single remote 'origin'" do
      it "should return the URL for the remote" do
        resource[:source] = 'http://example.com'
        provider.expects(:git).with('remote').returns("origin\n")
        provider.expects(:git).with('config', '--get', 'remote.origin.url').returns('http://example.com')
        expect(provider.source).to eq(resource.value(:source))
      end
    end

    context "when there's more than one remote" do
      it "should return the remotes as a hash" do
        resource[:source] = {"origin" => "git://git@foo.com/bar.git", "other" => "git://git@foo.com/baz.git"}
        provider.expects(:git).with('remote').returns("origin\nother\n")
        provider.expects(:git).with('config', '--get', 'remote.origin.url').returns('git://git@foo.com/bar.git')
        provider.expects(:git).with('config', '--get', 'remote.other.url').returns('git://git@foo.com/baz.git')
        expect(provider.source).to eq(resource.value(:source))
      end
    end
  end

  context "updating remotes" do

    context "from string to string" do
      it "should fail" do
        resource[:source] = 'git://git@foo.com/bar.git'
        resource[:force] = false

        provider.expects(:source).returns('git://git@foo.com/foo.git')
        provider.expects(:path_exists?).returns(true)
        provider.expects(:path_empty?).returns(false)
        expect { provider.source = resource.value(:source) }.to raise_error(Puppet::Error)
      end
    end

    context "from hash to hash" do
      it "should add any new remotes, update any existing remotes, remove deleted remotes" do
        expects_chdir
        resource[:source] = {"origin" => "git://git@foo.com/bar.git", "new_remote" => "git://git@foo.com/baz.git"}
        provider.expects(:source).returns(
          {'origin' => 'git://git@foo.com/foo.git',
           'old_remote' => 'git://git@foo.com/old.git'})
        provider.expects(:git).at_least_once.with('config', '-l').returns("remote.old_remote.url=git://git@foo.com/old.git\n", "remote.origin.url=git://git@foo.com/foo.git\n")
        provider.expects(:git).with('remote', 'remove', 'old_remote')
        provider.expects(:git).with('remote', 'set-url', 'origin', 'git://git@foo.com/bar.git')
        provider.expects(:git).with('remote', 'add', 'new_remote', 'git://git@foo.com/baz.git')
        provider.expects(:git).with('remote','update')
        provider.source = resource.value(:source)
      end
    end

    context "from string to hash" do
      it "should add any new remotes, update origin remote" do
        expects_chdir
        resource[:source] = {"origin" => "git://git@foo.com/bar.git", "new_remote" => "git://git@foo.com/baz.git"}
        provider.expects(:source).returns('git://git@foo.com/foo.git')
        provider.expects(:git).at_least_once.with('config', '-l').returns("remote.origin.url=git://git@foo.com/foo.git\n")
        provider.expects(:git).with('remote', 'set-url', 'origin', 'git://git@foo.com/bar.git')
        provider.expects(:git).with('remote', 'add', 'new_remote', 'git://git@foo.com/baz.git')
        provider.expects(:git).with('remote','update')
        provider.source = resource.value(:source)
      end
    end

    context "from hash to string" do
      it "should update origin remote, remove deleted remotes" do
        expects_chdir
        resource[:source] = "git://git@foo.com/baz.git"
        provider.expects(:source).returns(
          {'origin' => 'git://git@foo.com/foo.git',
           'old_remote' => 'git://git@foo.com/old.git'})
        provider.expects(:git).with('remote', 'remove', 'old_remote')
        provider.expects(:git).at_least_once.with('config', '-l').returns("remote.origin.url=git://git@foo.com/foo.git\n", "remote.other.url=git://git@foo.com/bar.git\n")
        provider.expects(:git).with('remote', 'set-url', 'origin', 'git://git@foo.com/baz.git')
        provider.expects(:git).with('remote','update')
        provider.source = resource.value(:source)
      end
    end
  end

  context "updating references" do
    it "should use 'git fetch --tags'" do
      resource.delete(:source)
      expects_chdir
      provider.expects(:git).with('fetch', 'origin')
      provider.expects(:git).with('fetch', '--tags', 'origin')
      provider.update_references
    end
  end

  describe 'latest?' do
    context 'when true' do
      it do
        provider.expects(:revision).returns('testrev')
        provider.expects(:latest_revision).returns('testrev')
        expect(provider.latest?).to be_truthy
      end
    end
    context 'when false' do
      it do
        provider.expects(:revision).returns('master')
        provider.expects(:latest_revision).returns('testrev')
        expect(provider.latest?).to be_falsey
      end
    end
  end

end
