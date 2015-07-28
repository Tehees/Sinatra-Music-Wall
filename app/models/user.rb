class User < ActiveRecord::Base 
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true

  has_many :songs

  has_many :likes
  has_many :liked_songs, through: :likes

  def self.authenticate_user(username, password)
    puts username
    user = User.find_by_username username
    if user == nil
      false
    else
      if user.password == password
        true
      end
    end
  end
end