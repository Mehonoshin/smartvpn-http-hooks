require File.expand_path('../billing', __FILE__)

module Api
  class Activation < Billing
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
      data
    end

    def data
      {
        # TODO: we should subscribe initial activation with secret key
        # instead of relying on node IP
        #secret_key: ENV['SECRET_KEY'],
        hostname: hostname
      }
    end

    def action
      "activate"
    end
  end
end
