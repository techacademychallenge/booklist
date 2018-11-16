class HavesController < ApplicationController
  def create
    @book = Book.find_or_initialize_by(isbn: params[:book_isbn])
    
    unless @book.persisted?
      result = RakutenWebService::Books::Book.search(isbn: @book.isbn).first
      category = get_genre_name(result['booksGenreId'])
      
      book_params = read(result).merge!({category: category})
      @book = Book.new(book_params)
      unless @book.save
        flash[:danger] = "#{@book.title}を持っているリストに追加できませんでした。"
      else
        current_user.have(@book)
        flash[:success] = "#{@book.title}を持っているリストに追加しました。"
      end
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @book = Book.find(params[:book_id])
    
    current_user.unhave(@book)
    flash[:success] = "#{@book.title}を持っているリストから除外しました。"
    
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def get_genre_name(books_genre_id)
    result = RakutenWebService::Books::Genre.search({ booksGenreId: books_genre_id }).first.parents.first
    result['booksGenreName']
  end
end
