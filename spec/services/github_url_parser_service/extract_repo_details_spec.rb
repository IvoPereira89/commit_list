require 'rails_helper'

describe GithubUrlParserService::ExtractRepoDetails do
  describe "when called with a invalid url" do

    it "should raise exception" do
      expect{ described_class.call("http://asd.com") }.to raise_error("Invalid github url")
    end
  end

  describe "when called with a valids url" do

    it "should return correct details" do
      expect(described_class.call("https://github.com/owner/repo")).to eql({
        name: "repo",
        owner: "owner"
      })
    end
  end
end
