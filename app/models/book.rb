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

  class << self  
    def retrieve_books(keyword)
      books = []
      results = RakutenWebService::Books::Book.search({
        title: keyword,
      })
      results.each do |result|
        book = Book.find_or_initialize_by(read(result))
        books << book
      end
      books
    end
    
    def new_by_isbn(isbn)
      result = RakutenWebService::Books::Book.search(isbn: isbn).first
      category = get_genre_name(result['booksGenreId'])
      book_params = read(result).merge!({category: category})
      Book.new(book_params)
    end
    
    private
    
    def get_genre_name(books_genre_id)
      result = RakutenWebService::Books::Genre.search({ booksGenreId: books_genre_id }).first.parents.first
      result['booksGenreName']
    end
    
    def read(result)
      title = result['title']
      author = result['author']
      isbn = result['isbn']
      url = result['itemUrl']
      image_url = result['mediumImageUrl'].gsub('?_ex=128x128', '')
      
      {
        title: title,
        author: author,
        isbn: isbn,
        url: url,
        image_url: image_url,
      }
    end
  end
end
