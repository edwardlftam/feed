require './app/actions/action'

module Actions::Feeds
  class Index < Action
    def params
      return @params if @params

      super.require(:user_id)
      @params = super.permit(:user_id)
      @params 
    end

    def perform
      user = User.find(params[:user_id])    
      success! user.feeds.as_json
    end
  end
end