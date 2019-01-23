require 'spec_helper'

describe Api::Activation do
  subject { described_class.new }

  describe '.activate' do
    mock_pki_files

    context 'when node is already activated' do
      before do
        expect(File)
          .to receive(:exist?)
          .with('/etc/openvpn/auth_key')
          .and_return(true)
      end

      it 'does not make http calls' do
        expect(subject).not_to receive(:activated_successfully?)
        subject.activate
      end
    end

    context 'successful activation' do
      before do
        stub_request(:post, 'api.smartvpn.biz/api/activate')
          .with(body: {
            secret_token: ENV['SECRET_TOKEN'],
            hostname:     ENV['HOSTNAME'],
            server_crt:   'crt content',
            client_crt:   'client crt content',
            client_key:   'client key content'
          }
        )
      end

      it 'saves key' do
        allow(subject).to receive(:save_auth_key)
        subject.activate
      end
    end

    context 'not successful activation' do
      before do
        stub_request(:post, 'api.smartvpn.biz/api/activate').to_return(status: '404')
      end

      it 'raises error' do
        expect {
          subject.activate
        }.to raise_error "Can't activate server at billing"
      end
    end
  end
end
