require 'rspec/autorun'
require 'webmock/rspec'
require 'openvpn-http-hooks'

RSpec.configure do |config|
  config.mock_with :mocha
end


