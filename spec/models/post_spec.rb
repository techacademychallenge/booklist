require 'rails_helper'

RSpec.describe Post, type: :model do
  before do
    @user = User.new(
      name: "Aaron Sumner",
      email: "tester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
      password_confirmation: "dottle-nouveau-pavilion-tights-furze"
    )
    
    @book = Book.new(
      title: "タイトル",
      author: "著者",
      isbn: "11111111111111111",
      url: "https://sample.com",
      image_url: "https://image.com",
      category: "category"
    )
  end
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    post = FactoryBot.build(:post)
    expect(post).to be_valid
  end
  
  # ユーザ、ブック、コンテンツがあれば有効な状態であること
  it "is valid with a user, book and content" do
    post = Post.new(
      user: @user,
      book: @book,
      content: "content"
    )
    expect(post).to be_valid
  end
  
  # コンテンツがなければ無効な状態であること
  it "is invalid without a content" do
    post = FactoryBot.build(:post, content: nil)
    post.invalid?
    expect(post.errors[:content]).to include("can't be blank")
  end
  
  # コンテンツが255文字のとき有効な状態であること
  it "is valid when a content is 255 characters" do
    post = FactoryBot.build(:post, content: "a" * 255)
    expect(post).to be_valid
  end
  
  # コンテンツが256文字のとき無効な状態であること
  it "is invalid when a content is 256 characters" do
    post = FactoryBot.build(:post, content: "a" * 256)
    post.invalid?
    expect(post.errors[:content]).to include("is too long (maximum is 255 characters)")
  end
end
