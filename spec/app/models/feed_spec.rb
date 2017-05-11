require 'model_helper'

describe Feed do
  describe 'validations' do
    context "when name exceeds maximum length" do
      let(:invalid_name) { 'a' * 256 }
      subject { build :feed, name: invalid_name }
      it "is invalid" do
        expect(subject).not_to be_valid
        expect(subject.errors.full_messages.first).to include('Name is too long')
      end
    end

    context "when name is missing" do
      subject { build :feed, name: nil }
      it "is invalid" do
        expect(subject).not_to be_valid
        expect(subject.errors.full_messages.first).to include("Name can't be blank")
      end
    end

    describe "associations" do
      let(:feed) { create :feed }
      let!(:article) { create :article, feed_id: feed.id }
      subject { feed }
      it "has association to aritcles" do
        expect(subject.articles.first).to be_a(Article)
      end
    end
  end
end