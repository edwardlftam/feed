require 'model_helper'

describe Article do
  describe "validations" do
    context "when author is missing" do
      subject { build :article, author: nil }
      it "is invalid" do
        expect(subject).not_to be_valid
        expect(subject.errors.full_messages.first).to include("Author can't be blank")
      end
    end

    context "when title is missing" do
      subject { build :article, title: nil }
      it "is invalid" do
        expect(subject).not_to be_valid
        expect(subject.errors.full_messages.first).to include("Title can't be blank")
      end
    end

    context "when feed_id is missing" do
      subject { build :article, feed: nil }
      it "is invalid" do
        expect(subject).not_to be_valid
        expect(subject.errors.full_messages.first).to include("Feed must exist")
      end
    end
  end

  describe "associations" do
    let(:article) { create :article }
    it "belongs to a feed" do
      expect(article.feed).to be_a(Feed)
    end
  end
end