require 'spec_helper'

describe Puppet::Type.type(:vcsrepo).provider(:git_provider) do
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
    context "with a revision that is a remote branch" do
      it "should execute 'git clone' and 'git checkout -b'" do
        resource[:revision] = 'only/remote'
        Dir.expects(:chdir).with('/').at_least_once.yields
        Dir.expects(:chdir).with('/tmp/test').at_least_once.yields
        provider.expects(:git).with('clone', resource.value(:source), resource.value(:path))
        provider.expects(:update_submodules)
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
        provider.expects(:git).with('clone', '--depth', '1', resource.value(:source), resource.value(:path))
        provider.expects(:update_submodules)
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
        provider.expects(:git).with('branch', '-a').returns(branch_a_list(resource.value(:revision)))
        provider.expects(:git).with('checkout', '--force', resource.value(:revision))
        provider.create
      end

      it "should execute 'git clone' and submodule commands" do
        resource.delete(:revision)
        provider.expects(:git).with('clone', resource.value(:source), resource.value(:path))
        provider.expects(:update_submodules)
        provider.create
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
          provider.create
        end
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

          provider.expects(:bare_exists?).returns(false)
          provider.expects(:git).with('init')
          provider.create
        end
      end

      context "when the path is a bare repository" do
        it "should convert it to a working copy" do
          resource[:ensure] = :present
          resource.delete(:source)
          provider.expects(:bare_exists?).returns(true)
          provider.expects(:convert_bare_to_working_copy)
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

    context "when the path does not exist" do
      it "should execute 'git init --bare'" do
        resource[:ensure] = :bare
        resource.delete(:source)
        resource.delete(:revision)
        expects_chdir
        expects_mkdir
        expects_directory?(false)
        provider.expects(:working_copy_exists?).returns(false)
        provider.expects(:git).with('init', '--bare')
        provider.create
      end
    end

    context "when the path is a working copy repository" do
      it "should convert it to a bare repository" do
        resource[:ensure] = :bare
        resource.delete(:source)
        resource.delete(:revision)
        provider.expects(:working_copy_exists?).returns(true)
        provider.expects(:convert_working_copy_to_bare)
        provider.create
      end
      it "should clone overtop it using force" do
        resource[:force] = true
        Dir.expects(:chdir).with('/').at_least_once.yields
        Dir.expects(:chdir).with('/tmp/test').at_least_once.yields
        provider.expects(:path_exists?).returns(true)
        provider.expects(:path_empty?).returns(false)
        provider.destroy
        provider.expects(:git).with('clone',resource.value(:source), resource.value(:path))
        provider.expects(:update_submodules)
        provider.expects(:git).with('branch', '-a').returns(branch_a_list(resource.value(:revision)))
        provider.expects(:git).with('checkout', '--force', resource.value(:revision))
        provider.create
      end
      it "should warn about destroying it using force and noop attribute" do
        resource[:force] = true
        resource[:noop] = true
        resource.delete(:revision)
        provider.expects(:working_copy_exists?).returns(true)

        provider.expects(:destroy).never
        provider.expects(:create).never
        Puppet::Type::Vcsrepo::Ensure.any_instance.expects(:send_log).with(:notice, "Noop Mode - Would have deleted repository and re-created from latest")
        provider.resource.retrieve
      end
      it "should warn about destroying it using force and global noop" do
        resource[:force] = true
        Puppet[:noop] = true
        resource.delete(:revision)
        provider.expects(:working_copy_exists?).returns(true)

        provider.expects(:destroy).never
        provider.expects(:create).never
        Puppet::Type::Vcsrepo::Ensure.any_instance.expects(:send_log).with(:notice, "Noop Mode - Would have deleted repository and re-created from latest")
        provider.resource.retrieve
      end
    end

    context "when the path is not empty and not a repository" do
      it "should raise an exception" do
        provider.expects(:path_exists?).returns(true)
        provider.expects(:path_empty?).returns(false)
        provider.expects(:working_copy_exists?).returns(false)
        expect { provider.create }.to raise_error(Puppet::Error)
      end
    end
  end


  context 'destroying' do
    it "it should remove the directory" do
      #expects_rm_rf
      provider.destroy
    end
  end

  context "checking the revision property" do
    before do
      expects_chdir('/tmp/test')
      resource[:revision] = 'currentsha'
      resource.delete(:source)
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
        expect(provider.revision).to eq(resource.value(:revision))
      end
    end

    context "when its SHA is different than the current SHA" do
      it "should return the current SHA" do
        provider.expects(:git).with('rev-parse', resource.value(:revision)).returns('othersha')
        expect(provider.revision).to eq(resource.value(:revision))
      end
    end

    context "when its a ref to a remote head" do
      it "should return the revision" do
        provider.stubs(:git).with('branch', '-a').returns("  remotes/origin/#{resource.value(:revision)}")
        provider.expects(:git).with('rev-parse', "origin/#{resource.value(:revision)}").returns("newsha")
        expect(provider.revision).to eq(resource.value(:revision))
      end
    end

    context "when its a ref to non existant remote head" do
      it "should fail" do
        provider.expects(:git).with('branch', '-a').returns(branch_a_list)
        provider.expects(:git).with('rev-parse', '--revs-only', resource.value(:revision)).returns('')

        expect { provider.revision }.to raise_error(Puppet::Error, /not a local or remote ref$/)
      end
    end

    context "when the source is modified" do
      it "should update the origin url" do
        resource[:source] = 'git://git@foo.com/bar.git'
        provider.expects(:git).with('config', 'remote.origin.url').returns('old')
        provider.expects(:git).with('config', 'remote.origin.url', 'git://git@foo.com/bar.git')
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

  context "updating references" do
    it "should use 'git fetch --tags'" do
      resource.delete(:source)
      expects_chdir
      provider.expects(:git).with('config', 'remote.origin.url').returns('')
      provider.expects(:git).with('fetch', 'origin')
      provider.expects(:git).with('fetch', '--tags', 'origin')
      provider.update_references
    end
  end

  context "checking if revision" do
    before do
      expects_chdir
      provider.expects(:git).with('branch', '-a').returns(fixture(:git_branch_a))
    end
    context "is a local branch" do
      context "when it's listed in 'git branch -a'" do
        it "should return true" do
          resource[:revision] = 'feature/foo'
          expect(provider).to be_local_branch_revision
        end
      end
      context "when it's not listed in 'git branch -a'" do
        it "should return false" do
          resource[:revision] = 'feature/notexist'
          expect(provider).not_to be_local_branch_revision
        end
      end
    end
    context "is a remote branch" do
      context "when it's listed in 'git branch -a' with an 'origin/' prefix" do
        it "should return true" do
          resource[:revision] = 'only/remote'
          expect(provider).to be_remote_branch_revision
        end
      end
      context "when it's not listed in 'git branch -a' with an 'origin/' prefix" do
        it "should return false" do
          resource[:revision] = 'only/local'
          expect(provider).not_to be_remote_branch_revision
        end
      end
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

  describe 'convert_working_copy_to_bare' do
    it do
      FileUtils.expects(:mv).returns(true)
      FileUtils.expects(:rm_rf).returns(true)
      FileUtils.expects(:mv).returns(true)

      provider.instance_eval { convert_working_copy_to_bare }
    end
  end

    describe 'convert_bare_to_working_copy' do
    it do
      FileUtils.expects(:mv).returns(true)
      FileUtils.expects(:mkdir).returns(true)
      FileUtils.expects(:mv).returns(true)
      provider.expects(:commits_in?).returns(true)
      # If you forget to stub these out you lose 3 hours of rspec work.
      provider.expects(:reset).with('HEAD').returns(true)
      provider.expects(:git_with_identity).returns(true)
      provider.expects(:update_owner_and_excludes).returns(true)

      provider.instance_eval { convert_bare_to_working_copy }
    end
  end

end
