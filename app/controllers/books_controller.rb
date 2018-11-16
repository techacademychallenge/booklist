class BooksController < ApplicationController
  def show
    @book = Book.find(params[:id])
    @posts = @book.posts.order('created_at DESC').page(params[:page]).per(10)
    @have_users = @book.users
    @post = Book.find(params[:id]).posts.build
  end
end
