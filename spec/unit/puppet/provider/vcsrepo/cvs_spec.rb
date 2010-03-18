require 'pathname'; Pathname.new(__FILE__).realpath.ascend { |x| begin; require (x + 'spec_helper.rb'); break; rescue LoadError; end }

describe_provider :vcsrepo, :cvs, :resource => {:path => '/tmp/vcsrepo'} do

  describe 'creating' do
    context "with a source", :resource => {:source => ':ext:source@example.com:/foo/bar'} do
      context_with :revision do
        it "should execute 'cvs checkout' and 'cvs update -r'" do
          expects_chdir
          expects_chdir(File.dirname(resource.value(:path)))
          provider.expects(:cvs).with('-d', resource.value(:source), 'checkout', '-d', File.basename(resource.value(:path)), File.basename(resource.value(:source)))
          provider.expects(:cvs).with('update', '-r', resource.value(:revision), '.')
          provider.create
        end        
      end
      
      context_without :revision do
        it "should just execute 'cvs checkout' without a revision" do
          provider.expects(:cvs).with('-d', resource.value(:source), 'checkout', '-d', File.basename(resource.value(:path)), File.basename(resource.value(:source)))
          provider.create
        end        
      end
      
      context "with a compression", :resource => {:compression => '3'} do
        it "should just execute 'cvs checkout' without a revision" do
          provider.expects(:cvs).with('-d', resource.value(:source), '-z', '3', 'checkout', '-d', File.basename(resource.value(:path)), File.basename(resource.value(:source)))
          provider.create
        end        
      end
    end
    
    context "when a source is not given" do
      it "should execute 'cvs init'" do
        provider.expects(:cvs).with('-d', resource.value(:path), 'init')
        provider.create
      end
    end
  end

  describe 'destroying' do
    it "it should remove the directory" do
      FileUtils.expects(:rm_rf).with(resource.value(:path))
      provider.destroy
    end
  end

  describe "checking existence" do
    context_with :source do
      it "should check for the CVS directory" do
        File.expects(:directory?).with(File.join(resource.value(:path), 'CVS'))
        provider.exists?
      end
    end
    
    context_without :source do
      it "should check for the CVSROOT directory" do
        File.expects(:directory?).with(File.join(resource.value(:path), 'CVSROOT'))
        provider.exists?
      end
    end
  end

  describe "checking the revision property" do
    before do
      @tag_file = File.join(resource.value(:path), 'CVS', 'Tag')
    end
    
    context "when CVS/Tag exists" do
      before do
        @tag = 'HEAD'
        File.expects(:exist?).with(@tag_file).returns(true)
      end
      it "should read CVS/Tag" do
        File.expects(:read).with(@tag_file).returns("T#{@tag}")
        provider.revision.should == @tag
      end
    end
    
    context "when CVS/Tag does not exist" do
      before do
        File.expects(:exist?).with(@tag_file).returns(false)
      end
      it "assumes MAIN" do
        provider.revision.should == 'MAIN'        
      end
    end
  end
  
  describe "when setting the revision property" do
    before do
      @tag = 'SOMETAG'
    end
    
    it "should use 'cvs update -r'" do
      expects_chdir
      provider.expects('cvs').with('update', '-r', @tag, '.')
      provider.revision = @tag
    end
  end

end