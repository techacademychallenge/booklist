class ToppagesController < ApplicationController
  def index
    books = []
    @keyword = params[:keyword]
    if @keyword.present?
      books = Book.retrieve_books(@keyword)
      @books = Kaminari.paginate_array(books, total_count: books.count).page(params[:page]).per(12)
    end
  end
end
