require 'spec_helper'

describe Option::Base do
  subject { described_class }
  let(:common_name) { "login" }
  let(:attributes) { Hash[] }

  describe 'activate' do
    it 'creates instance of class and calls activate! on it' do
      object = mock()
      object.expects(:activate!)
      subject.expects(:new).with(common_name, attributes).returns(object)
      subject.activate(common_name, attributes)
    end
  end

  describe 'deactivate' do
    it 'creates instance of class and calls deactivate! on it' do
      object = mock()
      object.expects(:deactivate!)
      subject.expects(:new).with(common_name, attributes).returns(object)
      subject.deactivate(common_name, attributes)
    end
  end

end
