require File.expand_path('../billing', __FILE__)

module Api
  class Authentication < Billing
    def initialize(login, password)
      @login, @password = login, password
    end

    def valid_credentials?
      success_api_call?
    end

    private

    def data
      {
        login: @login,
        password: @password,
        hostname: hostname
      }
    end

    def action
      "auth"
    end
  end
end
