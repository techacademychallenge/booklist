require 'rails_helper'

RSpec.describe Book, type: :model do
  before do
    @new_book = Book.new(
      title: "タイトル",
      author: "著者",
      isbn: "11111111111111111",
      url: "https://sample.com",
      image_url: "https://image.com",
      category: "category"
    )
    @char255 = "a" * 255
    @char256 = "a" * 256
  end

  # タイトル、著者、ISBN、URL、画像URL、カテゴリーがあれば有効な状態であること
  it "is valid with a title, author, isbn, url, image_url and category" do
    book = Book.new(
      title: "タイトル",
      author: "著者",
      isbn: "11111111111111111",
      url: "https://sample.com",
      image_url: "https://image.com",
      category: "category"
    )
    expect(book).to be_valid
  end
  
  # タイトルがなければ無効な状態であること
  it "is invalid without a title" do
    book = Book.new(title: nil)
    book.invalid?
    expect(book.errors[:title]).to include("can't be blank")
  end
  
  # タイトルが255文字のとき有効な状態であること
  it "is valid when a title is 255 characters" do
    @new_book.title = @char255
    expect(@new_book).to be_valid
  end
  
  # タイトルが256文字でとき無効な状態であること
  it "is invalid when a title is 256 characters" do
    book = Book.new(title: @char256)
    book.invalid?
    expect(book.errors[:title]).to include("is too long (maximum is 255 characters)")
  end
  
  # 著者がなくても有効な状態であること
  it "is valid without an author" do
    @new_book.author = nil
    expect(@new_book).to be_valid
  end
  
  # 著者が255文字のとき有効な状態であること
  it "is valid when an author is 255 characters" do
    @new_book.author = @char255
    expect(@new_book).to be_valid
  end
  
  # 著者が256文字のとき無効な状態であること
  it "is invalid when an author is 256 characters" do
    book = Book.new(author: @char256)
    book.invalid?
    expect(book.errors[:author]).to include("is too long (maximum is 255 characters)")
  end
  
  # ISBNがなければ無効な状態であること
  it "is invalid without an isbn" do
    book = Book.new(isbn: nil)
    book.invalid?
    expect(book.errors[:isbn]).to include("can't be blank")
  end
  
  # ISBNが255文字のとき有効な状態であること
  it "is valid when an isbn is 255 characters" do
    @new_book.isbn = @char255
    expect(@new_book).to be_valid
  end
  
  # ISBNが256文字のとき無効な状態であること
  it "is invalid when an isbn is 256 characters" do
    book = Book.new(isbn: @char256)
    book.invalid?
    expect(book.errors[:isbn]).to include("is too long (maximum is 255 characters)")
  end
  
  # URLがなければ無効な状態であること
  it "is invalid without a url" do
    book = Book.new(url: nil)
    book.invalid?
    expect(book.errors[:url]).to include("can't be blank")
  end
  
   # URLが255文字のとき有効な状態であること
  it "is valid when a url is 255 characters" do
    @new_book.url = @char255
    expect(@new_book).to be_valid
  end
  
  # URLが256文字のとき無効な状態であること
  it "is invalid when a url is 256 characters" do
    book = Book.new(url: @char256)
    book.invalid?
    expect(book.errors[:url]).to include("is too long (maximum is 255 characters)")
  end
  
   # 画像URLがなければ無効な状態であること
  it "is invalid without a image_url" do
    book = Book.new(image_url: nil)
    book.invalid?
    expect(book.errors[:image_url]).to include("can't be blank")
  end
  
  # 画像URLが255文字のとき有効な状態であること
  it "is valid when a image_url is 255 characters" do
    @new_book.image_url = @char255
    expect(@new_book).to be_valid
  end
  
  # 画層URLが256文字のとき無効な状態であること
  it "is invalid when a image_url is 256 characters" do
    book = Book.new(image_url: @char256)
    book.invalid?
    expect(book.errors[:image_url]).to include("is too long (maximum is 255 characters)")
  end
  
  # カテゴリがなければ無効な状態であること
  it "is invalid without a category" do
    book = Book.new(category: nil)
    book.invalid?
    expect(book.errors[:category]).to include("can't be blank")
  end
  
  # カテゴリが255文字のとき有効な状態であること
  it "is valid when a category is 255 characters" do
    @new_book.category = @char255
    expect(@new_book).to be_valid
  end
  
  # カテゴリが256文字のとき無効な状態であること
  it "is invalid when a category is 256 characters" do
    book = Book.new(category: @char256)
    book.invalid?
    expect(book.errors[:category]).to include("is too long (maximum is 255 characters)")
  end
  
end