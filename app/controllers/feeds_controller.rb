require './app/actions/feeds'

class FeedsController < ApplicationController
  def index
    Actions::Feeds::Index.new(self).perform
  end

  def subscribe
    Actions::Feeds::Subscribe.new(self).perform
  end

  def unsubscribe
    Actions::Feeds::Unsubscribe.new(self).perform
  end
end