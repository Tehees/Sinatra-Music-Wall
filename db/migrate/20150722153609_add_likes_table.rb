class AddLikesTable < ActiveRecord::Migration
    def change
    create_table :likes do |t|
      t.integer :song_id
      t.integer :user_id
    end
  end
end
