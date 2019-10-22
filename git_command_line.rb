require 'pry-rails'
require 'open3'

class GitCommandLine
  def initialize(url, repo_name)
    @url = url
    @repo_name = repo_name
    @commit = nil
  end

  def commit_list
    output = "cd tmp/#{@repo_name} && git log"
    output, _, _ = Open3.capture3(output)
    output
  end

  def setup_local
    system "cd tmp && git clone #{@url}"

  end

  def clean_up_local
    system "rm -rf tmp/#{@repo_name}"
  end

end
