require 'rails_helper'

describe FeedsController, type: :controller do
  let(:user_1) { create :user }
  let(:user_2) { create :user }
  let(:feed_1) { create :feed, name: 'Feed 1' }
  let(:feed_2) { create :feed, name: 'Feed 2' }
  let(:sub_1) { create :subscription, feed_id: feed_1.id, user_id: user_1.id}
  let(:sub_2) { create :subscription, feed_id: feed_2.id, user_id: user_2.id}

  describe "GET #index"  do
    before { user_1; user_2; feed_1; feed_2; sub_1; sub_2 }

    it "returns the feeds of the given user" do
      get :index, params: { user_id: user_1.id }
      expect(response.status).to eq(200)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response).to be_a Array
      expect(parsed_response).to have_exactly(1).item
      expect(parsed_response.first['id']).to eq(feed_1.id)
    end
  end

  describe "POST #subscribe" do
    let(:execute)  { post :subscribe, params: { user_id: user_1.id, id: feed_1.id } }

    it "returns OK with status 200" do
      execute
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['result']).to eq('OK')
      expect(response.status).to eq(200)
    end

    it "subscribes the given user to the feed" do
      expect { execute }
        .to change { Subscription.all.count }
        .by(1)
    end

    context "when user id is invalid" do
      it "returns proper error message and status" do
        post :subscribe, params: { user_id: 9999, id: feed_1.id }
        parsed_response = JSON.parse(response.body)
        expect(response.status).to eq(422)
        expect(parsed_response['error']['message']).to include('User must exist')
      end
    end
  end

  describe "DELETE #unsubscribe" do
    let(:execute) { delete :unsubscribe, params: { user_id: user_1.id, id: feed_1.id } }

    before { sub_1 }

    it "returns OK with status 200" do
      execute
      parsed_response = JSON.parse(response.body)
      expect(parsed_response['result']).to eq('OK')
      expect(response.status).to eq(200)
    end

    it "unsubscribes the given user to the feed" do
      expect { execute }
        .to change { Subscription.all.count }
        .by(-1)
    end
  end
end