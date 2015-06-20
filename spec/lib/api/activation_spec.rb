require 'spec_helper'

describe Api::Activation do
  subject { described_class.new }

  describe '.activate' do
    context 'successful activation' do
      before do
        stub_request(:post, 'api.smartvpn.biz/api/activate')
      end

      it 'saves key' do
        subject.expects(:save_auth_key)
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
        }.to raise_error
      end
    end
  end
end
