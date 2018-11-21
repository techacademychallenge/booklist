class HavesController < ApplicationController
  def create
    @book = Book.find_or_initialize_by(isbn: params[:book_isbn])
    if @book.new_record?
      @book = Book.new_by_isbn(@book.isbn)
      if @book.save
        current_user.add(@book)
        flash[:success] = "#{@book.title}を持っているリストに追加しました。"
      else
        flash[:danger] = "#{@book.title}を持っているリストに追加できませんでした。"
      end
    else
      current_user.add(@book)
      flash[:success] = "#{@book.title}を持っているリストに追加しました。"
    end
    
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @book = Book.find(params[:book_id])
    
    current_user.remove(@book)
    flash[:success] = "#{@book.title}を持っているリストから除外しました。"
    
    redirect_back(fallback_location: root_path)
  end
end
