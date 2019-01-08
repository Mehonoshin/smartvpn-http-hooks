require 'rspec/autorun'
require 'webmock/rspec'
require 'smartvpn-http-hooks'

RSpec.configure do |config|
  config.mock_with :mocha
end


