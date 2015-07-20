class Song < ActiveRecord::Base
  validates :title, presence: true, length: { maximum: 40 }
  validates :author, presence: true, length: { maximum: 140 }
  validates :url, presence: true, length: { maximum: 200 }

  
end