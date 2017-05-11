require './app/actions/action'

module Actions::Articles
  class Create < Action
    def params
      return @params if @params

      super.require(:feed_id)
      super.require(:article)
      
      @params = super.permit(:feed_id)
      @params = @params.merge(
        article: super[:article].permit(:author, :title, :subtitle, :content)) 
      @params 
    end

    def perform
      article_attrs = params[:article].merge(feed_id: params[:feed_id])
      article = Article.create!(article_attrs)
      created! article.as_json
    end
  end
end