class Song < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 40 }
  validates :author, presence: true, length: { maximum: 140 }
  validates :url, presence: true, length: { maximum: 200 }

  belongs_to :user

  has_many :likes
  has_many :likers, through: :likes

  has_many :reviews
  has_many :reviwers, through: :reviews


end