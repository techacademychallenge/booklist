class ToppagesController < ApplicationController
  def index
    books = []
    @keyword = params[:keyword]
    if @keyword.present?
      books = []
      results = RakutenWebService::Books::Book.search({
        title: @keyword,
      })
      
      results.each do | result|
        book = Book.find_or_initialize_by(read(result))
        books << book
      end
      @books = Kaminari.paginate_array(books, total_count: results.count).page(params[:page]).per(12)
    end
  end
end
