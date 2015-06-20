require 'spec_helper'

describe Option::Repository do
  describe '.find_by_code' do
    subject { described_class.find_by_code(option_code) }

    context 'option exists' do
      let(:option_code) { 'i2p' }

      it 'returns option class by code' do
        expect(subject).to eq Option::I2p
      end
    end

    context 'option does not exist' do
      let(:option_code) { 'some_option' }

      it 'raises error' do
        expect {
          subject
        }.to raise_error OptionNotFound
      end
    end
  end
end
