class Feed < ApplicationRecord
  validates :name, length: { maximum: 255 }, presence: true, uniqueness: true

  has_many :subscriptions
  has_many :users, through: :subscriptions
  has_many :articles
end