require 'spec_helper'

describe System::OpenvpnStatusLogReader do
  let!(:file_contents) { File.read('spec/fixtures/active_connections.txt') }
  let(:common_name) { "e0c187715fa9e1bb9fd96882dfa7af22" }
  let(:path_to_log) { described_class::LOGFILE_PATH }

  before { allow(File).to receive(:read).with(path_to_log).and_return(file_contents) }

  describe '.vpn_ip' do
    subject { described_class }

    it 'creates new instance and vpn_ip_for on it' do
      object = double()
      expect(object).to receive(:vpn_ip_for).with(common_name)
      expect(subject).to receive(:new).and_return(object)
      subject.vpn_ip(common_name)
    end
  end

  describe '.new' do
    it 'reads logfile' do
      object = described_class.new
      expect(object.log_content).not_to be_nil
    end
  end

  describe '.vpn_ip_for' do
    it 'returns user virtual ip by common name' do
      expect(described_class.vpn_ip(common_name)).to eq '10.77.2.6'
    end
  end
end
