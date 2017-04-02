require 'spec_helper'

describe 'vcsrepo::hiera' do
  describe 'default params' do
    it { is_expected.to have_resource_count(0) }
  end

  describe 'with wrong param type' do
    let(:params) { { repo: 'some string' } }

    it do
      expect { catalogue }.to raise_error(Puppet::PreformattedError, %r{'repo' expects a Hash})
    end
  end

  test_one = { 'repo_one' => { 'ensure' => 'present',
                               'source' => 'giturl',
                               'provider' => 'git' } }
  describe 'with with entry' do
    let(:params) { { repo: test_one } }

    it { is_expected.to have_resource_count(1) }
    it do
      is_expected.to contain_vcsrepo('repo_one').with(
        'ensure'   => 'present',
        'provider' => 'git',
        'source'   => 'giturl'
      )
    end
  end

  test_multi = { 'repo_one' => { 'ensure' => 'present',
                                 'source' => 'giturl',
                                 'provider' => 'git' },
                 'repo_two' => { 'ensure' => 'present',
                                 'source' => 'giturl2',
                                 'provider' => 'git' } }
  describe 'with multipole entries' do
    let(:params) { { repo: test_multi } }

    it { is_expected.to have_resource_count(2) }
    it do
      is_expected.to contain_vcsrepo('repo_one').with(
        'source' => 'giturl'
      )
      is_expected.to contain_vcsrepo('repo_two').with(
        'source' => 'giturl2'
      )
    end
  end
end
