require File.expand_path('../billing', __FILE__)

module Api
  class Connection < Billing
    def invoke_if_valid_api_call(&block)
      yield if success_api_call?
      trigger_script_return
    end

    def trigger_script_return
      if success_api_call?
        exit 0
      else
        exit 1
      end
    end

    def common_name
      response["common_name"]
    end

    def options
      result = {}
      option_codes.reduce(result) do |options_with_codes, option_code|
        options_with_codes[option_code] =
          {
            option_class: Option::Repository.find_by_code(option_code),
            attributes: attributes_for_option(option_code)
          }
        options_with_codes
      end
      result
    end

    private

    def data
      {
        hostname: hostname,
        traffic_in: traffic_in,
        traffic_out: traffic_out,
        login: ENV['common_name']
      }
    end

    def option_codes
      response["options"]
    end

    def option_attributes
      response["option_attributes"]
    end

    def attributes_for_option(code)
      option_attributes[code]
    end

    def traffic_in
      ENV['bytes_received'] || "0"
    end

    def traffic_out
      ENV['bytes_sent'] || "0"
    end
  end
end
