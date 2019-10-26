class CommitsService::FetchGithubCommits < ApplicationService
  def initialize(params)
    @params = params
  end

  def call
    api = Github::Api.new(@params)
    commits = api.fetch_commits
    parse(commits)
  end

  private

  def parse(commits)
    commits.map do |c|
      commit = c[:commit]
      Commit.new(
        commit_id: c[:node_id],
        author: commit[:author][:name],
        date: commit[:author][:date],
        message: commit[:message]
      )
    end
  end
end
