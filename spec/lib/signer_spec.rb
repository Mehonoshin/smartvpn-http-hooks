require 'spec_helper'

describe Signer do
  describe ".sign_hash" do
    let(:hash) { Hash[a: "a", c: "c", b: "b"] }
    let(:key) { "some_key" }
    subject { described_class.sign_hash(hash, key) }

    it "sorts hash by values" do
      expect(subject).not_to eq Digest::MD5.hexdigest("#{hash.values.join}#{key}")
    end

    it "joins values" do
      expect(subject).not_to eq Digest::MD5.hexdigest("#{hash.values.sort}#{key}")
    end

    it "appends key to values" do
      expect(subject).not_to eq Digest::MD5.hexdigest("#{hash.values.sort.join}")
    end
  end
end
