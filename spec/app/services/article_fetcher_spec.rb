require 'model_helper'

describe ArticleFetcher do
  let(:user) { create :user }
  let(:feed1) { create :feed }
  let(:feed2) { create :feed }
  let!(:sub1) { create :subscription, user_id: user.id, feed_id: feed1.id }
  let!(:sub2) { create :subscription, user_id: user.id, feed_id: feed2.id }
  let!(:article1) { create :article, feed_id: feed1.id }
  let!(:article2) { create :article, feed_id: feed2.id }

  describe "#fetch_by_user" do
    context "when sort_by_feeds is set to true" do
      subject { ArticleFetcher.new(user.id, sort_by_feeds: true) }

      it "fetches articles and sort them by feeds" do
        payload = subject.fetch
        expect(payload).to have_exactly(2).items
        expect(payload.all? { |feed| feed.has_key?(:articles) }).to be true
      end
    end

    context "when sort_by_feeds is set to false" do
      subject { ArticleFetcher.new(user.id, sort_by_feeds: false) }

      it "fetchres articles and return them as an array" do
        payload = subject.fetch
        expect(payload).to be_a Array
        expect(payload).to have_exactly(2).items

        article_ids = payload.map { |a| a[:id] }
        expect(article_ids).to include(article1.id)
        expect(article_ids).to include(article2.id)
      end
    end
  end
end