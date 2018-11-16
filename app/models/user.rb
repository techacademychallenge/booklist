class User < ApplicationRecord
  before_save { self.email.downcase! }
  
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :haves, class_name: 'Have'
  has_many :books, through: :haves
  has_many :posts
  
  def have(book)
    self.haves.find_or_create_by(book_id: book.id)
  end
  
  def unhave(book)
    have = self.haves.find_by(book_id: book.id)
    have.destroy
  end
  
  def have?(book)
    self.books.include?(book)
  end
  
end
