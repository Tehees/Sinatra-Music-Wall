class AddUsernameColumn < ActiveRecord::Migration
  def change
    add_column :reviews, :username, :string
  end
end
