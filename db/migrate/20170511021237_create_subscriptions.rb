class CreateSubscriptions < ActiveRecord::Migration[5.1]
  def change
    create_table :subscriptions do |t|
      t.integer :user_id, null: false, limit: 8
      t.integer :feed_id, null: false, limit: 8
    end

    add_foreign_key :subscriptions, :users
    add_foreign_key :subscriptions, :feeds
  end
end
