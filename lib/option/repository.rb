module Option
  class Repository
    class << self
      def find_by_code(code)
        index[code.to_s] || raise(OptionNotFound)
      end

      private

      def index
        @index ||= {
          'i2p'   => Option::I2p,
          'proxy' => Option::Proxy
        }
      end
    end
  end
end
