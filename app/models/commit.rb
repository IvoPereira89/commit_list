class Commit

  attr_accessor :commit_id
  attr_accessor :date
  attr_accessor :author
  attr_accessor :message

  def initialize(params = {})
    @commit_id = params[:commit_id]
    @date = params[:date]
    @author = params[:author]
    @message = params[:message]
  end

  def update_attributes(params = {})
    @commit_id = params[:commit_id] if params.key?(:commit_id)
    @date = params[:date] if params.key?(:date)
    @author = params[:author] if params.key?(:author)
    @message = params[:message] if params.key?(:message)
  end
end
