class Article < ApplicationRecord
  validates :author, presence: true
  validates :title, presence: true

  belongs_to :feed
end