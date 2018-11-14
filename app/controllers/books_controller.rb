class BooksController < ApplicationController
  def search
    @books = []
    @keyword = params[:keyword]
    if @keyword.present?
      results = RakutenWebService::Books::Book.search({
        title: @keyword,
      })
      
      results.each do | result|
        book = Book.new(read(result))
        @books << book
      end
    end
    render 'toppages/index'
  end
  
  private
  
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
