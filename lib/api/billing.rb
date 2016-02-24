require "socket"
require 'net/http'
require 'json'
require File.expand_path('../../signer', __FILE__)

module Api
  class Billing
    API_HOST = '/etc/openvpn/API_HOST'
    KEY_PATH = '/etc/openvpn/auth_key'

    def host_with_port
      host =  File.read(API_HOST)
      "http://#{host.strip}"
    end

    def auth_key
      File.read(KEY_PATH)
    end

    def hostname
      Socket.gethostname
    end

    def success_api_call?
      api_call_result.code == '200'
    end

    def response
      JSON.parse(api_call_result.body)
    end

    def api_call_result
      @api_result ||= Net::HTTP.post_form(uri, signed_data)
    end

    def uri
      URI("#{host_with_port}/api/#{action}")
    end

    def signed_data
      data.merge!({ signature: Signer.sign_hash(data, auth_key) })
    end
  end
end
