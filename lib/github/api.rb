module Github
  class Api
    def initialize(params)
      @repository_name = params[:name]
      @owner = params[:owner]
    end

    def client
      @client ||= Octokit::Client.new
    end

    def repository
      @repository ||= client.repo("#{@owner}/#{@repository_name}")
    end

    def fetch_commits
      client.commits(repository[:id])
    end
  end
end
