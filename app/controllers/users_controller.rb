class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:show]
  
  def show
    @user = User.find(params[:id])
    if params.has_key?(:category)
      @books = @user.books.where(category: params[:category]).page(params[:page]).per(12)
    else
      @books = @user.books.page(params[:page]).per(12)
    end
    @have_count = @user.books.count
    @categories = @user.books.group(:category).count(:category)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
