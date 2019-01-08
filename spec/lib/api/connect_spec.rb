require 'spec_helper'

describe Api::Connect do
  subject { described_class.new }

  describe '#invoke' do
    before do
      allow(subject).to receive(:response).and_return(
        JSON.parse(
          '{"id":101,"common_name":"login","options":["i2p", "proxy"],"option_attributes":{"i2p":{"attr1": "value1"},"proxy":{"attr2": "value2"}}}'
        )
      )
      allow(subject).to receive(:trigger_script_return)
      allow(subject).to receive(:success_api_call?).and_return(api_call_validation_result)
    end

    context 'successfull script call' do
      let(:api_call_validation_result) { true }

      it 'activates options' do
        allow_any_instance_of(Option::I2p)
          .to receive(:activate!)
        allow_any_instance_of(Option::Proxy)
          .to receive(:activate!)
        subject.invoke
      end
    end

    context 'unsuccessfull call' do
      let(:api_call_validation_result) { false }

      it 'does not activate options' do
        allow_any_instance_of(Option::I2p)
          .to receive(:activate!).never
        subject.invoke
      end
    end
  end

  it 'represents connect action' do
    expect(subject.action).to eq 'connect'
  end
end
