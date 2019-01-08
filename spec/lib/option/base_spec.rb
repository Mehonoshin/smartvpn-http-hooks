require 'spec_helper'

describe Option::Base do
  subject { described_class }
  let(:common_name) { "login" }
  let(:attributes) { Hash[] }

  describe 'activate' do
    it 'creates instance of class and calls activate! on it' do
      object = double()
      expect(object).to receive(:activate!)
      expect(subject).to receive(:new).with(common_name, attributes).and_return(object)
      subject.activate(common_name, attributes)
    end
  end

  describe 'deactivate' do
    it 'creates instance of class and calls deactivate! on it' do
      object = double()
      expect(object).to receive(:deactivate!)
      expect(subject).to receive(:new).with(common_name, attributes).and_return(object)
      subject.deactivate(common_name, attributes)
    end
  end
end
