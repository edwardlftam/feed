class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.integer :feed_id, null: false, limit: 8
      t.string :author, null: false
      t.string :title, null: false
      t.string :subtitle
      t.mediumtext :content
      t.datetime :deleted_at
      t.timestamps
    end

    add_foreign_key :articles, :feeds
  end
end
