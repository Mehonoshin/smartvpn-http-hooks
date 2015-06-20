require 'spec_helper'

describe Api::Disconnect do
  subject { described_class.new }

  describe '#invoke' do
    before do
      subject.stubs(:response).returns(
        JSON.parse(
          '{"id":101,"common_name":"login","options":["i2p", "proxy"],"option_attributes":{"i2p":{"attr1": "value1"},"proxy":{"attr2": "value2"}}}'
        )
      )
      subject.stubs(:trigger_script_return)
      subject.stubs(:success_api_call?).returns(api_call_validation_result)
    end

    context 'successfull script call' do
      let(:api_call_validation_result) { true }

      it 'activates options' do
        Option::I2p.any_instance.expects(:deactivate!)
        Option::Proxy.any_instance.expects(:deactivate!)
        subject.invoke
      end
    end

    context 'unsuccessfull call' do
      let(:api_call_validation_result) { false }

      it 'does not activate options' do
        Option::I2p.any_instance.expects(:deactivate!).never
        subject.invoke
      end
    end
  end

  it 'represents disconnect action' do
    expect(subject.action).to eq 'disconnect'
  end
end
