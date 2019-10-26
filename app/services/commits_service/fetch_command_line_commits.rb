class CommitsService::FetchCommandLineCommits < ApplicationService
  def initialize(params)
    @repository_name = params[:name]
    @url = params[:url]
  end

  def call
    setup_local
    commits = commit_list
    clean_up_local
    parse(commits)
  end

  private

  def commit_list
    output = "cd tmp/#{@repository_name} && git log"
    output, _, _ = Open3.capture3(output)
    output
  end

  def setup_local
    system "cd tmp && git clone #{@url}"

  end

  def clean_up_local
    system "rm -rf tmp/#{@repository_names}"
  end

  def parse(raw_commits)
    commits = []
    commits_lines = raw_commits.split("\n")

    commit = { message: "" }

    commits_lines.each do |line|
      if is_id?(line)
        if commit.key?(:commit_id)
          commits.push(Commit.new(commit))
          commit = { message: "" }
        end
        line.slice!("commit ")
        commit[:commit_id] = line
      elsif is_author?(line)
        line.slice!("Author: ")
        commit[:author] = line
      elsif is_message?(line)
        commit[:message] += "#{line}\n"
      elsif is_date?(line)
        line.slice!("Date: ")
        commit[:date] = line
      end
    end

    commits.push(Commit.new(commit)) if commit.key?(:commit_id)
    commits
  end

  def is_id?(line)
    line.match(/^commit .*/)
  end

  def is_author?(line)
    line.match(/^Author: .*/)
  end

  def is_date?(line)
    line.match(/^Date: .*/)
  end

  def is_message?(line)
    line.match(/^    .*/)
  end
end
