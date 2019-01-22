module Smartvpn
  module Mocks
    def mock_pki_files
      before do
        allow(File)
          .to receive(:read)
          .with('/hooks/pki/keys/ca.crt')
          .and_return('crt content')

        allow(File)
          .to receive(:read)
          .with('/hooks/pki/keys/generic_client.crt')
          .and_return('client crt content')

        allow(File)
          .to receive(:read)
          .with('/hooks/pki/keys/generic_client.key')
          .and_return('client key content')
      end
    end
  end
end
