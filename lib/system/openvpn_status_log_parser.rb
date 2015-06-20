module System
  class OpenvpnStatusLogParser
    attr_accessor :status, :clients_block, :text

    def initialize(text)
      @status = System::OpenvpnStatus.new
      @clients_block = false
      @text = text
      parse
    end

    def parse
      @text.lines.each do |line|
        line_tokens = line.strip.split(',')
        parse_client_virtual_ips(line_tokens)
      end
    end

    private

    def parse_client_virtual_ips(tokens)
      @clients_block = false if tokens[0] == 'GLOBAL STATS'
      if clients_block
        common_name, ip_address = tokens[1], tokens[0]
        @status.clients_list[common_name] = ip_address
      end
      @clients_block = true if tokens[0] == 'Virtual Address'
    end
  end
end
