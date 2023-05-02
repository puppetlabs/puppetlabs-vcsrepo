# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'vcsrepo::manage::svn' do
  let(:pp) { 'include vcsrepo::manage::svn' }

  it 'applies idempotently' do
    idempotent_apply(pp)
  end

  it 'installs svn' do
    expect(package('subversion')).to be_installed
  end
end
