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
      begin
        @repository ||= x("#{@owner}/#{@repository_name}")
      rescue => exception
        raise exception
      end
    end

    def fetch_commits
      begin
        client.commits(repository[:id])
      rescue => exception
        raise exception
      end
    end
  end
end
