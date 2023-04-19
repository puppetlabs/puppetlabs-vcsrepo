# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'changing revision' do
  before(:all) do
    create_repo

    # Configure testrepo.git as upstream of testrepo
    pp = <<-MANIFEST
    vcsrepo { "#{tmpdir}/testrepo":
      ensure   => present,
      provider => git,
      revision => 'a_branch',
      source   => "file://#{tmpdir}/testrepo.git",
    }
    MANIFEST
    apply_manifest(pp, catch_failures: true)
  end

  after(:all) do
    run_shell("rm -rf #{tmpdir}/testrepo.git")
  end

  shared_examples 'switch to branch/tag/sha' do
    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo":
        ensure   => latest,
        provider => git,
        revision => 'a_branch',
        source   => "file://#{tmpdir}/testrepo.git",
      }
    MANIFEST
    it 'pulls the new branch commits' do
      idempotent_apply(pp)
    end

    pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo":
        ensure   => latest,
        provider => git,
        revision => '0.0.3',
        source   => "file://#{tmpdir}/testrepo.git",
      }
    MANIFEST
    it 'checks out the tag' do
      idempotent_apply(pp)
    end

    it 'checks out the sha' do
      sha = run_shell("cd #{tmpdir}/testrepo && git rev-parse origin/main").stdout.chomp
      pp = <<-MANIFEST
      vcsrepo { "#{tmpdir}/testrepo":
        ensure   => latest,
        provider => git,
        revision => '#{sha}',
        source   => "file://#{tmpdir}/testrepo.git",
      }
      MANIFEST
      idempotent_apply(pp)
    end
  end

  context 'when on branch' do
    before :each do
      run_shell("cd #{tmpdir}/testrepo && git checkout a_branch")
      run_shell("cd #{tmpdir}/testrepo && git reset --hard 0.0.2")
    end

    it_behaves_like 'switch to branch/tag/sha'
  end

  context 'when on tag' do
    before :each do
      run_shell("cd #{tmpdir}/testrepo && git checkout 0.0.1")
    end

    it_behaves_like 'switch to branch/tag/sha'
  end

  context 'when on detached head' do
    before :each do
      run_shell("cd #{tmpdir}/testrepo && git checkout 0.0.2")
      run_shell("cd #{tmpdir}/testrepo && git checkout HEAD~1")
    end

    it_behaves_like 'switch to branch/tag/sha'
  end
end
