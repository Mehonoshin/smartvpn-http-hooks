module Api
  class Disconnect < Connection
    def invoke
      invoke_if_valid_api_call do
        deactivate_options
      end
    end

    def action
      'disconnect'
    end

    private

    def deactivate_options
      options.each do |code, data|
        data[:option_class].deactivate(common_name, data[:attributes])
      end
    end
  end
end
