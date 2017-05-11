class ArticleFetcher
  attr_accessor :user, :sort_by_feeds

  def initialize(user_id, sort_by_feeds: false)
    @user          = User.find(user_id)
    @sort_by_feeds = sort_by_feeds
  end
  
  def fetch
    if sort_by_feeds
      combine(feeds, articles)
    else
      articles
    end
  end

private

  def feeds
    return @feeds if @feeds

    sql = <<-SQL
      SELECT
        f.id, f.name
      FROM
        feeds f
        JOIN subscriptions s ON f.id = s.feed_id
        JOIN users u ON s.user_id = u.id
      WHERE 
        u.id = #{user.id}
        AND f.deleted_at IS NULL;
    SQL

    @feeds = ActiveRecord::Base.connection.execute(sql).map do |feed_data|
      {}.tap { |h| h[:id], h[:name] = feed_data }
    end

    @feeds
  end

  def articles
    return @articles if @articles

    sql = <<-SQL
      SELECT
        id, author, title, subtitle, content, feed_id
      FROM
        articles
      WHERE
        feed_id IN (#{feeds.map { |f| f[:id] }.join(',') });
    SQL

    @articles = ActiveRecord::Base.connection.execute(sql).map do |article_data|
      {}.tap do |h|
        h[:id], h[:author], h[:title], h[:subtitle], h[:content], h[:feed_id] = article_data
      end
    end

    @articles
  end

  def combine(feeds, articles)
    payload = feeds.map do |feed|
      feed[:articles] = articles.select { |a| a[:feed_id] == feed[:id] }
      feed
    end

    payload
  end
  
end