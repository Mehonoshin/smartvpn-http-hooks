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
      expect(subject).to receive(:start_proxy_daemon).and_return(9090)
      expect(subject).to receive(:add_firewall_rules).with(9090)
      subject.activate!
    end
  end

  describe '.deactivate!' do
    it 'has attributes assigned' do
      expect(subject.attributes).to eq attributes
    end

    it 'stops daemon, removes firewall rule and cleans relays list' do
      allow_any_instance_of(Option::Proxy::RelayManager)
        .to receive(:free)
        .with(anything)
        .and_return(9090)
      expect(subject).to receive(:remove_firewall_rules).with(9090)
      expect(subject).to receive(:kill_proxy_daemon).with(9090)
      subject.deactivate!
    end
  end
end
