class CommitsController < ApplicationController
  include Pagy::Backend

  def index
    # get commits
    page = params[:page] || nil
    page_size = params[:page_size] || 25

    details = GithubUrlParserService::ExtractRepoDetails.call(params[:url])
    commits = CommitsService::FetchCommits.call(details)

    result = page ? pagy(commits, page: page, items: page_size) : commits
    render json: result
  end
end
