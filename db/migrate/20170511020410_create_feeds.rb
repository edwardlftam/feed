class CreateFeeds < ActiveRecord::Migration[5.1]
  def change
    create_table :feeds do |t|
      t.string :name, null: false, index: true
      t.datetime :deleted_at 
      t.timestamps
    end
  end
end
