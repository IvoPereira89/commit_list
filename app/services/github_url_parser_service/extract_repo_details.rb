class GithubUrlParserService::ExtractRepoDetails < ApplicationService
  def initialize(url)
    @url = url
  end

  def call
    begin
      raise "Invalid github url" unless validate
      url_parts = @url.split('/')
      {
        name: url_parts[-1],
        owner: url_parts[-2]
      }
    rescue => exception
      raise exception
    end
  end

  private

  def validate
    @url.match(/^https:\/\/(www.)?github.com\/(\S)+\/(\S)+/)
  end
end
