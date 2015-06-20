require 'spec_helper'

describe Api::Connect do
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
        Option::I2p.any_instance.expects(:activate!)
        Option::Proxy.any_instance.expects(:activate!)
        subject.invoke
      end
    end

    context 'unsuccessfull call' do
      let(:api_call_validation_result) { false }

      it 'does not activate options' do
        Option::I2p.any_instance.expects(:activate!).never
        subject.invoke
      end
    end
  end

  it 'represents connect action' do
    expect(subject.action).to eq 'connect'
  end
end
