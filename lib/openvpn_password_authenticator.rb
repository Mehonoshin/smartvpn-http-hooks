class OpenvpnPasswordAuthenticator
  attr_accessor :api

  def initialize(args, api_adapter_class)
    content = File.read(args[0])
    @login, @password = content.split("\n")
    @api = api_adapter_class.new(@login, @password)
  end

  def authenticate
    if @api.valid_credentials?
      exit 0
    else
      exit 1
    end
  end

end
