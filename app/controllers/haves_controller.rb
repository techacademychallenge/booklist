class HavesController < ApplicationController
  def create
    @book = Book.find_or_initialize_by(isbn: params[:book_isbn])
    
    unless @book.persisted?
      @book = Book.new_by_isbn(@book.isbn)
      unless @book.save
        flash[:danger] = "#{@book.title}を持っているリストに追加できませんでした。"
      else
        current_user.have(@book)
        flash[:success] = "#{@book.title}を持っているリストに追加しました。"
      end
    else
      current_user.have(@book)
      flash[:success] = "#{@book.title}を持っているリストに追加しました。"
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @book = Book.find(params[:book_id])
    
    current_user.unhave(@book)
    flash[:success] = "#{@book.title}を持っているリストから除外しました。"
    
    redirect_back(fallback_location: root_path)
  end
end
