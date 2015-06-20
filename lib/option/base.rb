module Option
  class Base
    attr_accessor :common_name, :attributes

    class << self
      def activate(common_name, attributes={})
        option_object = new(common_name, attributes)
        option_object.activate!
      end

      def deactivate(common_name, attributes={})
        option_object = new(common_name, attributes)
        option_object.deactivate!
      end
    end

    def initialize(common_name, attributes)
      @common_name = common_name
      @attributes  = attributes
    end

    def virtual_ip
      System::OpenvpnStatus.current_virtual_address
    end

    def server_virtual_ip
      System::OpenvpnStatus.server_virtual_address
    end
  end
end
