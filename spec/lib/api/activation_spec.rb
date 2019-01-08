require 'spec_helper'

describe Api::Activation do
  subject { described_class.new }

  api_host_defined

  describe '.activate' do
    context 'when node is already activated' do
      before do
      end
    end

    context 'successful activation' do
      before do
        stub_request(:post, 'api.smartvpn.biz/api/activate')
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
