require './app/actions/action'

module Actions::Feeds
  class Subscribe < Action
    def params
      return @params if @params

      super.require(:user_id)
      super.require(:id)

      @params = super.permit(:user_id, :id)
      @params 
    end

    def perform
      Subscription.where(user_id: params[:user_id], feed_id: params[:id]).first_or_create!
      success!(result: 'OK')
    end
  end
end