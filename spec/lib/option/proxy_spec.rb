require 'spec_helper'

describe Option::Proxy do
  subject { described_class.new(common_name, attributes) }
  let(:common_name) { 'login' }
  let(:attributes) { Hash[] }

  describe '.activate!' do
    it 'has attributes assigned' do
      expect(subject.attributes).to eq attributes
    end

    it 'it starts proxy daemon and firewall rules' do
      subject.expects(:start_proxy_daemon).returns(9090)
      subject.expects(:add_firewall_rules).with(9090)
      subject.activate!
    end
  end

  describe '.deactivate!' do
    it 'has attributes assigned' do
      expect(subject.attributes).to eq attributes
    end

    it 'stops daemon, removes firewall rule and cleans relays list' do
      Option::Proxy::RelayManager.any_instance.stubs(:free).with(anything).returns(9090)
      subject.expects(:remove_firewall_rules).with(9090)
      subject.expects(:kill_proxy_daemon).with(9090)
      subject.deactivate!
    end
  end
end
