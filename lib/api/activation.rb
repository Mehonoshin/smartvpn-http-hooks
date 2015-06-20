require File.expand_path('../billing', __FILE__)

module Api
  class Activation < Billing

    def activate
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

    def save_auth_key
      key = JSON.parse(api_call_result.body)["auth_key"]
      File.open('/etc/openvpn/auth_key', 'w') { |file| file.write(key) }
    end

    def signed_data
      data
    end

    def data
      {
        hostname: hostname
      }
    end

    def action
      "activate"
    end
  end
end
