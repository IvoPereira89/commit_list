class CommitsController < ApplicationController
  def index
    render json: { error: "Missing url parameter" }, status: :bad_request and return unless params.key?(:url)

    begin
      details = GithubUrlParserService::ExtractRepoDetails.call(params[:url])
    rescue => exception
       render json: { error: exception } and return unless params.key?(:url)
    end

    begin
      result = CommitsService::FetchGithubCommits.call(details)
    rescue => exception
      result = CommitsService::FetchCommandLineCommits.call(details.merge(url: params[:url]))
    end

    render json: { error: result[:error] }, status: result[:status] and return unless result.kind_of?(Array)

    page = params[:page] || 0
    page_size = params[:page_size] || 25

    render json: { data: PageIt.fetch(result, page.to_i, page_size.to_i) }
  end
end
