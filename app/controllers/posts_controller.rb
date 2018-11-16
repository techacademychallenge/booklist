class PostsController < ApplicationController
  def create
    @book = Book.find_by(id: post_params[:book_id])
    
    if @book && @book.users.include?(current_user)
      @post = @book.posts.build(content: post_params[:content], user_id: current_user.id)
      if @post.save
        flash[:success] = "#{@book.title}にコメントしました。"
      else
        flash[:danger] = "コメントに失敗しました。"
      end
    end
    redirect_back(fallback_location: root_path)  
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    flash[:success] = 'コメントを削除しました。'
    
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def post_params
    params.require(:post).permit(:book_id, :content)
  end
end
