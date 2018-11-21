class HavesController < ApplicationController
  def create
    @book = Book.find_or_initialize_by(isbn: params[:book_isbn])
    if @book.new_record?
      @book = Book.new_by_isbn(@book.isbn)
      @book.transaction do
        @book.save
        current_user.add(@book)
      end
    else
      current_user.add(@book)
    end
    
    flash[:success] = "#{@book.title}を持っているリストに追加しました。"
    redirect_back(fallback_location: root_path)
  rescue
    flash[:danger] = "#{@book.title}を持っているリストに追加できませんでした。"
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @book = Book.find(params[:book_id])
    
    current_user.remove(@book)
    flash[:success] = "#{@book.title}を持っているリストから除外しました。"
    
    redirect_back(fallback_location: root_path)
  end
end
