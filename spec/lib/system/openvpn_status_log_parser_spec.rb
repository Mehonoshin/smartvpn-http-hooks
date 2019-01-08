require 'spec_helper'

describe System::OpenvpnStatusLogParser do
  describe '.new' do
    subject { described_class }

    it 'calls parse method' do
      expect_any_instance_of(subject).to receive(:parse)
      subject.new("")
    end
  end

  describe 'parse' do
    let(:contents) { File.read('spec/fixtures/multiple_connections.txt') }
    subject { described_class.new(contents) }

    it 'returns status' do
      expect(subject.status.class).to eq System::OpenvpnStatus
    end

    it 'status includes all connected clients' do
      expect(subject.status.clients_list.size).to eq 2
    end
  end
end
