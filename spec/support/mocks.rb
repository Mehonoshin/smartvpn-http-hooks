module Smartvpn
  module Mocks
    def api_host_defined
      before do
        allow(File)
          .to receive(:read)
          .with(Api::Billing::API_HOST)
          .and_return('api.smartvpn.biz')
      end
    end
  end
end
