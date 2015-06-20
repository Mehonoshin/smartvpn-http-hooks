require 'spec_helper'
require 'tempfile'

describe OpenvpnPasswordAuthenticator do
  let!(:args) { [path_to_file] }
  let!(:file) { Tempfile.new('credentials') }
  let(:path_to_file) { file.path }
  let(:file_content) { "login\npassword" }
  let(:api_adapter_class) { Api::Authentication }
  subject { described_class.new(args, api_adapter_class) }

  before do
    file.write(file_content)
    file.rewind
  end

  describe ".new" do
    it "read file with credentials" do
      File.expects(:read).with(path_to_file).returns(file_content)
      subject
    end

    it "creates new adapter instance with credentials" do
      api_adapter_class.expects(:new).with('login', 'password')
      subject
    end
  end

  describe ".authenticate" do
    before do
      subject.api.stubs(:valid_credentials?).returns(validation_result)
    end

    context "credentials valid" do
      let(:validation_result) { true }

      it "exits with 0 code" do
        subject.expects(:exit).with(0)
        subject.authenticate
      end
    end

    context "credentials invaid" do
      let(:validation_result) { false }

      it "exits with 1 code" do
        subject.expects(:exit).with(1)
        subject.authenticate
      end
    end
  end
end
