class HavesController < ApplicationController
  def create
    @book = Book.find_or_initialize_by(isbn: params[:book_isbn])
    
    unless @book.persisted?
      results = RakutenWebService::Books::Book.search(isbn: @book.isbn)
      
      @book = Book.new(read(results.first))
      @book.save
    end
    
    current_user.have(@book)
    flash[:success] = "#{@book.title}を持っているリストに追加しました。"
    
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @book = Book.find(params[:book_id])
    
    current_user.unhave(@book)
    flash[:success] = "#{@book.title}を持っているリストから除外しました。"
    
    redirect_back(fallback_location: root_path)
  end
end
