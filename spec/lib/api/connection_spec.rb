require 'spec_helper'

describe Api::Connection do
  subject { described_class.new }

  describe '.invoke_if_valid_api_call' do
    before do
      subject.stubs(:success_api_call?).returns(success_status)
      subject.expects(:exit).with(exit_status)
    end

    context 'success' do
      let(:success_status) { true }
      let(:exit_status) { 0 }

      it 'exits with zero status' do
        subject.invoke_if_valid_api_call { "empty block" }
      end
    end

    context 'failure' do
      let(:success_status) { false }
      let(:exit_status) { 1 }

      it 'exits with non zero status' do
        subject.invoke_if_valid_api_call
      end
    end
  end

  describe 'attributes' do
    let(:option_name) { "i2p" }
    let(:common_name) { "login" }

    before do
      subject.stubs(:response).returns(
        JSON.parse(
          "{\"id\":101,\"common_name\":\"#{common_name}\",\"options\":[\"#{option_name}\", \"proxy\"],\"option_attributes\":{\"i2p\":{\"attr1\": \"value1\"},\"proxy\":{\"attr2\": \"value2\"}}}"
        )
      )
    end

    describe '.options' do
      it 'returns options array' do
        expect(subject.options.class).to eq Hash
      end

      it 'includes option name' do
        expect(subject.options['i2p'][:option_class]).to eq Option::I2p
      end
    end

    describe '.common_name' do
      it 'returns common name' do
        expect(subject.common_name).to eq common_name
      end
    end
  end
end
