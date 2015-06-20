module Option
  class I2p < Base
    def activate!
      add_firewall_routes
    end

    def deactivate!
      remove_firewall_routes
    end

    private

    def add_firewall_routes
      system "/sbin/iptables -t filter -D INPUT -p tcp -m tcp --dport 8118 -j DROP"
      system "/sbin/iptables -t filter -A INPUT -s #{virtual_ip} -p tcp -m tcp --dport 8118 -j ACCEPT"
      system "/sbin/iptables -t filter -A INPUT -p tcp -m tcp --dport 8118 -j DROP"
      system "/sbin/iptables -t nat -A PREROUTING -p udp -m udp -s #{virtual_ip} --dport 53 -j DNAT --to-destination #{server_virtual_ip}:53"
      system "/sbin/iptables -t nat -A PREROUTING -p tcp -m tcp -s #{virtual_ip} --dport 53 -j DNAT --to-destination #{server_virtual_ip}:53"
      true
    end

    def remove_firewall_routes
      system "/sbin/iptables -D INPUT -s #{virtual_ip} -p tcp -m tcp --dport 8118 -j ACCEPT"
      system "/sbin/iptables -t nat -D PREROUTING -p udp -m udp -s #{virtual_ip} --dport 53 -j DNAT --to-destination #{server_virtual_ip}:53"
      system "/sbin/iptables -t nat -D PREROUTING -p tcp -m tcp -s #{virtual_ip} --dport 53 -j DNAT --to-destination #{server_virtual_ip}:53"
    end
  end
end
