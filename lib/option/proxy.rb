module Option
  class Proxy < Base
    def activate!
      relay_port = start_proxy_daemon
      add_firewall_rules(relay_port)
    end

    def deactivate!
      relay_port = relay_manager.free(virtual_ip)
      remove_firewall_rules(relay_port)
      kill_proxy_daemon(relay_port)
    end

    private

      def start_proxy_daemon
        relay_port = relay_manager.next_available_port
        relay_manager.lock(virtual_ip, relay_port)
        system "/etc/openvpn/any_proxy -l :#{relay_port} -p '#{attributes['host']}:#{attributes['port']}' &"
        relay_port
      end

      def add_firewall_rules(relay_port)
        system "iptables -A PREROUTING -t nat -s #{virtual_ip}/32 -p tcp --dport 80 -j REDIRECT --to-port #{relay_port}"
        true
      end

      def kill_proxy_daemon(relay_port)
        pids = `ps -ef | grep #{relay_port} | awk '{ print $2 }'`
        relay_pid = pids.split( /\r?\n/ ).first
        `kill #{relay_pid} &`
        true
      end

      def remove_firewall_rules(relay_port)
        system "iptables -D PREROUTING -t nat -s #{virtual_ip}/32 -p tcp --dport 80 -j REDIRECT --to-port #{relay_port}"
      end

      def relay_manager
        RelayManager.new
      end

      class RelayManager
        RELAY_PORTS = [8090, 8091, 8092, 8093, 8094, 8095, 8096, 8097, 8098, 8099, 8010]
        STATUS_FILE = '/etc/openvpn/relays.txt'

        def lock(host, port)
          File.open(STATUS_FILE, 'a') { |f| f.puts("#{host} #{port} ") }
        end

        def free(host)
          list = File.readlines(STATUS_FILE).map { |l| l.split(' ') }
          port = list.find { |e| e[0] == host }[1]
          updated_list = list.reject { |e| e[0] == host }.join()
          File.open(STATUS_FILE, 'w') { |file| file.write(updated_list) }
          port
        end

        def next_available_port
          used_ports = File.readlines(STATUS_FILE).map { |l| l.split(' ')[1] }
          available_ports = RELAY_PORTS - used_ports
          available_ports.sample
        end
      end
  end
end
