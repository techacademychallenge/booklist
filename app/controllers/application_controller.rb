class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  include SessionsHelper
  
  private
  def require_user_logged_in
    unless logged_in? 
      redirect_to login_url
    end
  end
  
  def read(result)
    title = result['title']
    author = result['author']
    isbn = result['isbn']
    url = result['itemUrl']
    image_url = result['mediumImageUrl'].gsub('?_ex=128x128', '')
    
    {
      title: title,
      author: author,
      isbn: isbn,
      url: url,
      image_url: image_url,
    }
  end
end
