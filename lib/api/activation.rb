require File.expand_path('../billing', __FILE__)

module Api
  # This class executes an HTTP call to the API in billing,
  # when the node is started for the first time.
  # As a result of activation if receives an auth key,
  # which is used for signing all subsequent API calls.
  class Activation < Billing
    PKI_PATH = '/hooks/pki/keys'

    def activate
      return if active_node?

      if activated_successfully?
        save_auth_key
      else
        raise "Can't activate server at billing"
      end
    end

    private

    def activated_successfully?
      success_api_call?
    end

    def active_node?
      File.exist?(KEY_PATH)
    end

    def save_auth_key
      key = JSON.parse(api_call_result.body)["auth_key"]
      File.open('/etc/openvpn/auth_key', 'w') { |file| file.write(key) }
    end

    def signed_data
      # TODO: sign initial request with secret key
      data
    end

    def data
      {
        # TODO: we should subscribe initial activation with secret key
        # instead of relying on node IP
        # secret_key: ENV['SECRET_KEY'],
        hostname:   hostname,
        server_ca:  server_ca,
        client_ca:  client_ca,
        client_key: client_key
      }
    end

    def server_ca
      read_pki('ca.crt')
    end

    def client_ca
      read_pki('generic_client.crt')
    end

    def client_key
      read_pki('generic_client.key')
    end

    def action
      "activate"
    end

    def read_pki(file)
      File.read("#{PKI_PATH}/#{file}")
    end
  end
end
