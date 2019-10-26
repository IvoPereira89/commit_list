require 'rails_helper'

describe CommitsService::FetchCommandLineCommits do
  describe "when called with a valid repo" do
    let(:raw_commits) {
      "commit commit1\nAuthor: test_a\nDate: test_date\n    message1\n    message1.2\n" +
      "commit commit2\nAuthor: test_a2\nDate: test_date2\n    message2\n    message2.1\n"
    }

    before do
      allow_any_instance_of(described_class).to receive(:commit_list).and_return(raw_commits)
      allow_any_instance_of(described_class).to receive(:setup_local)
      allow_any_instance_of(described_class).to receive(:clean_up_local)
    end

    it "parses the commits" do
      result = described_class.call(name: "test", url: "test")
      expect(result.count).to eql(2)

      expect(result[0].commit_id).to eql("commit1")
      expect(result[0].author).to eql("test_a")
      expect(result[0].date).to eql("test_date")
      expect(result[0].message).to eql("    message1\n    message1.2\n")

      expect(result[1].commit_id).to eql("commit2")
      expect(result[1].author).to eql("test_a2")
      expect(result[1].date).to eql("test_date2")
      expect(result[1].message).to eql("    message2\n    message2.1\n")
    end
  end
end
