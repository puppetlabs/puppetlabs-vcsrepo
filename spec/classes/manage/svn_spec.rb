# frozen_string_literal: true

require 'spec_helper'

describe 'vcsrepo::manage::svn' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'when using defaults' do
        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_package('subversion').with_ensure('installed') }
        it { is_expected.to have_package_resource_count(1) }
      end

      context 'with params' do
        let(:params) do
          {
            package_name: 'testing',
            package_ensure: 'absent'
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_package('testing').with_ensure('absent') }
        it { is_expected.to have_package_resource_count(1) }
      end

      context 'with multiple packages' do
        let(:params) do
          {
            package_name: ['test', 'testing']
          }
        end

        it { is_expected.to compile.with_all_deps }
        it { is_expected.to contain_package('test').with_ensure('installed') }
        it { is_expected.to contain_package('testing').with_ensure('installed') }
        it { is_expected.to have_package_resource_count(2) }
      end
    end
  end
end
