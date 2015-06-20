require 'spec_helper'

describe Api::Billing do
  subject { described_class.new }

  it "returns api url" do
    expect(subject.host_with_port).to include "http://"
  end

  it "reads file with auth key" do
    File.stubs(:read).with(described_class::KEY_PATH).returns("key")
    expect(subject.auth_key).to eq "key"
  end

  it "returns machine hostname" do
    Socket.stubs(:gethostname).returns("hostname.dev")
    expect(subject.hostname).to eq "hostname.dev"
  end

  describe ".success_api_call?" do
    let(:api_call_result) { mock() }

    before do
      api_call_result.stubs(:code).returns(code)
      subject.stubs(:api_call_result).returns(api_call_result)
    end

    context "result is 404" do
      let(:code) { "404" }

      it "api call is not successful" do
        expect(subject.success_api_call?).to be_false
      end
    end

    context "result is 200" do
      let(:code) { "200" }

      it "api call is successful" do
        expect(subject.success_api_call?).to be_true
      end
    end
  end

  describe ".api_call_result" do
    before do
      stub_request(:post, 'api.smartvpn.biz/api/auth')
    end

    it "fetches HTTP response" do
      subject.stubs(:action).returns("auth")
      subject.stubs(:data).returns({})
      subject.stubs(:auth_key).returns("key")

      subject.api_call_result
      expect(subject.success_api_call?).to be_true
    end
  end

  it "returns URI for api call" do
    action = "auth"
    subject.stubs(:action).returns(action)
    expect(subject.uri).to eq URI("http://#{described_class::API_HOST}/api/#{action}")
  end

  it "adds signature to params hash" do
    subject.stubs(:auth_key).returns("key")
    subject.stubs(:data).returns({})
    expect(subject.signed_data).not_to be_empty
  end
end
