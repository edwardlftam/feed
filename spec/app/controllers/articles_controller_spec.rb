require 'rails_helper'

describe ArticlesController, type: :controller do
  let(:user) { create :user }
  let(:feed) { create :feed, name: 'Feed 1' }
  let(:sub) { create :subscription, feed_id: feed_1.id, user_id: user_1.id}

  describe "GET #index" do
    let(:stub_article_fetcher) { ArticleFetcher.new(user.id) }
    before do
      expect(ArticleFetcher).to receive(:new).with(user.id.to_s, { sort_by_feeds: true }).and_return(stub_article_fetcher)
      expect(stub_article_fetcher).to receive(:fetch).and_return([])
    end

    it "invokes article fetcher to fetch articles by user" do
      expect { get :index, params: { user_id: user.id, sort_by_feeds: true } }.not_to raise_error
    end
  end

  describe "POST #create" do
    let(:article_data) {{ author: 'Author', title: 'Title', subtitle: 'Subtitle', content: 'Text' }}
    let(:execute) { post :create, params: { feed_id: feed.id, article: article_data } }
    it "adds an article to the given feed" do
      expect { execute }.to change { Article.all.count }.by(1)
      parsed_response = JSON.parse(response.body)
      expect(response).to have_http_status(201)
    end
  end
end