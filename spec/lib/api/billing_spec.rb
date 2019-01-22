require 'spec_helper'

describe Api::Billing do
  subject { described_class.new }

  it 'returns api url' do
    expect(subject.host_with_port).to include 'http://'
  end

  it 'reads file with auth key' do
    allow(File).to receive(:read).with(described_class::KEY_PATH).and_return('key')
    expect(subject.auth_key).to eq 'key'
  end

  it 'returns machine hostname' do
    expect(subject.hostname).to eq 'test.smartvpn.biz'
  end

  describe '.success_api_call?' do
    let(:api_call_result) { double() }

    before do
      allow(api_call_result).to receive(:code).and_return(code)
      allow(subject).to receive(:api_call_result).and_return(api_call_result)
    end

    context "result is 404" do
      let(:code) { "404" }

      it "api call is not successful" do
        expect(subject.success_api_call?).to be false
      end
    end

    context "result is 200" do
      let(:code) { "200" }

      it "api call is successful" do
        expect(subject.success_api_call?).to be true
      end
    end
  end

  describe ".api_call_result" do
    before do
      stub_request(:post, 'api.smartvpn.biz/api/auth')
    end

    it "fetches HTTP response" do
      allow(subject).to receive(:action).and_return("auth")
      allow(subject).to receive(:data).and_return({})
      allow(subject).to receive(:auth_key).and_return("key")

      subject.api_call_result
      expect(subject.success_api_call?).to be true
    end
  end

  it "returns URI for api call" do
    action = "auth"
    allow(subject).to receive(:action).and_return(action)
    expect(subject.uri).to eq URI("#{subject.host_with_port}/api/#{action}")
  end

  it "adds signature to params hash" do
    allow(subject).to receive(:auth_key).and_return("key")
    allow(subject).to receive(:data).and_return({})
    expect(subject.signed_data).not_to be_empty
  end
end
