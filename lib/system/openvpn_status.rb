module System
  class OpenvpnStatus
    attr_accessor :clients_list

    class << self
      def current_virtual_address
        ENV['ifconfig_pool_remote_ip']
      end

      def server_virtual_address
        ENV['ifconfig_local']
      end
    end

    def initialize
      @clients_list = {}
    end
  end
end
