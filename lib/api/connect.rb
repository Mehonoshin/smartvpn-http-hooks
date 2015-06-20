module Api
  class Connect < Connection
    def invoke
      invoke_if_valid_api_call do
        activate_options
      end
    end

    def action
      'connect'
    end

    private

    def activate_options
      options.each do |code, data|
        data[:option_class].activate(common_name, data[:attributes])
      end
    end
  end
end
