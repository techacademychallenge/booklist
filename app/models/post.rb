class Post < ApplicationRecord
  belongs_to :user
  belongs_to :book
  
  validates :content, presence: true, length: { maximum: 255 }
end
