class GithubUrlParserService::ExtractRepoDetails
  def self.call(url)
    begin
      raise "invalid github url" unless validate(url)
      url_parts = url.split('/')
      {
        name: url_parts[-1],
        owner: url_parts[-2]
      }
    rescue => exception
      raise exception
    end
  end

  def self.validate(url)
    url.match(/^https:\/\/(www.)?github.com\/(\S)+\/(\S)+/)
  end
end
