def url_reader
  raise "Wrong number of arguments" if ARGV.length != 1

  uri = URI.parse(ARGV[0])
  raise "Invalid URL" unless uri.is_a?(URI::HTTP) && !uri.host.nil?

  ARGV[0]
end


def print_commits(commits)
end

def main
  begin
    url = url_reader
    repo_name = GithubUrlProcessor.extract_repo_name(url)
    command_line = GitCommandLine.new(url, repo_name)
    command_line.setup_local
    commits = command_line.commit_list
    command_line.clean_up_local
  rescue => error
    puts error
    return
  end

  puts commits
end

main
