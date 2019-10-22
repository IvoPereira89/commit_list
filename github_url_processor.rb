require 'uri'

class GithubUrlProcessor
  def self.extract_repo_name(url)
    begin
      raise "invalid github url" unless validate(url)
      url.split('/')[-1]
    rescue => exception
      raise exception
    end


  end

  def self.validate(url)
    url.match(/^https:\/\/(www.)?github.com\//)
  end
end
