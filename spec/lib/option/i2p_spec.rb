require 'spec_helper'

describe Option::I2p do
  subject { described_class.new('login', {}) }

  describe '.activate' do
    it 'adds firewall rules' do
      subject.expects(:add_firewall_routes)
      subject.activate!
    end
  end

  describe '.deactivate' do
    it 'removes firewall rules' do
      subject.expects(:remove_firewall_routes)
      subject.deactivate!
    end
  end
end
