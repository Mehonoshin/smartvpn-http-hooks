require 'spec_helper'

describe Option::I2p do
  subject { described_class.new('login', {}) }

  describe '.activate' do
    it 'adds firewall rules' do
      expect(subject).to receive(:add_firewall_routes)
      subject.activate!
    end
  end

  describe '.deactivate' do
    it 'removes firewall rules' do
      expect(subject).to receive(:remove_firewall_routes)
      subject.deactivate!
    end
  end
end
