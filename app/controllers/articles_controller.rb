require './app/actions/articles'

class ArticlesController < ApplicationController
  def index
    Actions::Articles::Index.new(self).perform
  end

  def create
    Actions::Articles::Create.new(self).perform
  end
end