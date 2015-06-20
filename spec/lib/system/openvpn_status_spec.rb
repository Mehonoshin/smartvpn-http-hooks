require 'spec_helper'

describe System::OpenvpnStatus do
  subject { described_class.new }

  describe '.current_virtual_address' do
    let(:virtual_address) { '10.0.0.1' }
    before { ENV['ifconfig_pool_remote_ip'] = virtual_address }

    it 'returns ENV vars value' do
      expect(described_class.current_virtual_address).to eq virtual_address
    end
  end

  it 'clients list is a hash' do
    expect(subject.clients_list.class).to eq Hash
  end

  it 'clients_list is empty' do
    expect(subject.clients_list).to be_empty
  end
end
