# frozen_string_literal: true

require 'spec_helper_acceptance'

describe 'vcsrepo::manage::git' do
  let(:pp) { 'include vcsrepo::manage::git' }

  it 'applies idempotently' do
    idempotent_apply(pp)
  end

  it 'installs git' do
    expect(package('git')).to be_installed
  end
end
