require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
Bundler.require(:default)

require 'dotenv/load'
require 'webmock/rspec'
require 'smartvpn-http-hooks'
require 'support/mocks'

RSpec.configure do |config|
  config.mock_with :rspec
  config.extend Smartvpn::Mocks
end
