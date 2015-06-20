module System
  class OpenvpnStatusLogReader
    LOGFILE_PATH = '/etc/openvpn/openvpn-status.log'

    attr_accessor :log_content

    class << self
      def vpn_ip(common_name)
        reader = new
        reader.vpn_ip_for common_name
      end
    end

    def initialize
      read_logfile
    end

    def vpn_ip_for(common_name)
      status = System::OpenvpnStatusLogParser.new(log_content).status
      status.clients_list[common_name]
    end

    private

    def read_logfile
      @log_content = File.read(LOGFILE_PATH)
    end
  end
end
