class AddReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :song_id
      t.integer :user_id
      t.string :review
      t.timestamp :created_at
      t.timestamp :updated_at
    end
  end
end
