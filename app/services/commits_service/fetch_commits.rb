class CommitsService::FetchCommits
  def self.call(details)
    api = Github::Api.new(details)
    commits = api.fetch_commits
    parse(commits)
  end

  def self.parse(commits)
    commits.map do |c|
      commit = c[:commit]
      {
        id: c[:node_id],
        author: commit[:author][:name],
        date: commit[:author][:date],
        message: commit[:message]
      }
    end
  end
end
