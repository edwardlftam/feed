require './app/actions/action'

module Actions::Feeds
  class Unsubscribe < Action
    def params
      return @params if @params

      super.require(:user_id)
      super.require(:id)

      @params = super.permit(:user_id, :id)
      @params 
    end

    def perform
      subscription = Subscription.find_by(user_id: params[:user_id], feed_id: params[:id])
      subscription.destroy if subscription
      success!(result: 'OK')
    end
  end
end