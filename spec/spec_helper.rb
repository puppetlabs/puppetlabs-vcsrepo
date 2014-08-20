require 'puppetlabs_spec_helper/module_spec_helper'
require 'support/filesystem_helpers'
require 'support/fixture_helpers'

unless RUBY_VERSION == '1.8.7'
  require 'simplecov'
  SimpleCov.start do
      add_filter "/spec/"
  end
end

RSpec.configure do |c|
  c.include FilesystemHelpers
  c.include FixtureHelpers
end
