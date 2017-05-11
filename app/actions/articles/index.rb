require './app/actions/action'

module Actions::Articles
  class Index < Action
    def params
      return @params if @params

      super.require(:user_id)
      @params = super.permit(:user_id, :sort_by_feeds)
      @params 
    end

    def perform
      payload = ArticleFetcher.new(params[:user_id], sort_by_feeds: !!params[:sort_by_feeds]).fetch
      success! payload
    end
  end
end