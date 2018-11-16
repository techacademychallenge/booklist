class Book < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :author, length: { maximum: 255 }
  validates :isbn, presence: true, length: { maximum: 255 }
  validates :url, presence: true, length: { maximum: 255 }
  validates :image_url, presence: true, length: { maximum: 255 }
  validates :category, presence: true, length: { maximum: 255 }
  
  has_many :haves, class_name: 'Have', dependent: :destroy
  has_many :users, through: :haves
  has_many :posts, dependent: :destroy
  
end
