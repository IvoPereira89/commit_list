require 'rails_helper'

describe CommitsService::FetchGithubCommits do
  describe "when called with a valid repo" do
    before do
      allow_any_instance_of(Github::Api).to receive(:initialize)
      allow_any_instance_of(Github::Api).to receive(:fetch_commits).and_return(
        [
          {
            node_id: "commit1",
            commit: {
              author: { name: "test_a", date: "test_date" },
              message: "message1"
            }
          },
          {
            node_id: "commit2",
            commit: {
              author: { name: "test_a2", date: "test_date2" },
              message: "message2"
            }
          }
        ]
      )
    end

    it "parses the commits" do
      result = described_class.call(name: "test", url: "test")
      expect(result.count).to eql(2)

      expect(result[0].commit_id).to eql("commit1")
      expect(result[0].author).to eql("test_a")
      expect(result[0].date).to eql("test_date")
      expect(result[0].message).to eql("message1")

      expect(result[1].commit_id).to eql("commit2")
      expect(result[1].author).to eql("test_a2")
      expect(result[1].date).to eql("test_date2")
      expect(result[1].message).to eql("message2")
    end
  end
end
