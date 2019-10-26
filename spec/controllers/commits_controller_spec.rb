require 'rails_helper'

RSpec.describe CommitsController, type: :controller do
  describe '#index' do
    context "when called without url param" do
      subject(:response) { send :get, :index }

      it "should return a bad request" do
        expect(response.status).to eql(400)
        expect(JSON.parse(response.body)["error"]).to eql("Missing url parameter")
      end
    end

    context "when called normally" do
      subject(:response) { send :get, :index, params: { url: "test_url"} }
      let(:mock_commit) {
        Commit.new(commit_id: "test_id", author: "my_author", date: "2019-09-30T15:22:22.000Z", message: "test message")
      }

      before do
         allow(GithubUrlParserService::ExtractRepoDetails).to receive(:call).and_return({})
         allow(CommitsService::FetchGithubCommits).to receive(:call).and_return([mock_commit])
      end

      it "it should return an array of commits" do
        expect(response.status).to eql(200)
        result = JSON.parse(response.body)
        expect(result["data"].count).to eql(1)
      end
    end

    context "when called with page and page size" do
      subject(:response) { send :get, :index, params: { url: "test_url", page: 2, page_size: 2} }
      let(:mock_commit) {
        Commit.new(commit_id: "test_id", author: "my_author", date: "2019-09-30T15:22:22.000Z", message: "test message")
      }
      let(:mock_commit_2) {
        Commit.new(commit_id: "test_id_2", author: "my_author", date: "2019-09-30T15:22:22.000Z", message: "test message")
      }
      let(:mock_commit_3) {
        Commit.new(commit_id: "test_id_3", author: "my_author", date: "2019-09-30T15:22:22.000Z", message: "test message")
      }
      let(:mock_commit_4) {
        Commit.new(commit_id: "test_id_4", author: "my_author", date: "2019-09-30T15:22:22.000Z", message: "test message")
      }

      before do
         allow(GithubUrlParserService::ExtractRepoDetails).to receive(:call).and_return({})
         allow(CommitsService::FetchGithubCommits).to receive(:call).and_return([mock_commit, mock_commit_2, mock_commit_3, mock_commit_4])
      end

      it "it should return an array of commits according to the params" do
        expect(response.status).to eql(200)
        result = JSON.parse(response.body)
        expect(result["data"].count).to eql(2)
        expect(result["data"][0]["commit_id"]).to eql("test_id_3")
        expect(result["data"][1]["commit_id"]).to eql("test_id_4")
      end
    end
  end

end
