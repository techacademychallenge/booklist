require 'rails_helper'

RSpec.describe Book, type: :model do
  before do
    @char255 = "a" * 255
    @char256 = "a" * 256
  end
  
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:book)).to be_valid
  end

  # タイトル、著者、ISBN、URL、画像URL、カテゴリーがあれば有効な状態であること
  it "is valid with a title, author, isbn, url, image_url and category" do
    book = Book.new(
      title: "タイトル",
      author: "著者",
      isbn: "1111111111111",
      url: "https://sample.com",
      image_url: "https://image.com",
      category: "category"
    )
    expect(book).to be_valid
  end
  
  # タイトルがなければ無効な状態であること
  it "is invalid without a title" do
    book = FactoryBot.build(:book, title: nil)
    book.invalid?
    expect(book.errors[:title]).to include("can't be blank")
  end
  
  # タイトルが255文字のとき有効な状態であること
  it "is valid when a title is 255 characters" do
    book = FactoryBot.build(:book, title: @char255)
    expect(book).to be_valid
  end
  
  # タイトルが256文字でとき無効な状態であること
  it "is invalid when a title is 256 characters" do
    book = FactoryBot.build(:book, title: @char256)
    book.invalid?
    expect(book.errors[:title]).to include("is too long (maximum is 255 characters)")
  end
  
  # 著者がなくても有効な状態であること
  it "is valid without an author" do
    book = FactoryBot.build(:book, author: nil)
    expect(book).to be_valid
  end
  
  # 著者が255文字のとき有効な状態であること
  it "is valid when an author is 255 characters" do
    book = FactoryBot.build(:book, author: @char255)
    expect(book).to be_valid
  end
  
  # 著者が256文字のとき無効な状態であること
  it "is invalid when an author is 256 characters" do
    book = FactoryBot.build(:book, author: @char256)
    book.invalid?
    expect(book.errors[:author]).to include("is too long (maximum is 255 characters)")
  end
  
  # ISBNがなければ無効な状態であること
  it "is invalid without an isbn" do
    book = FactoryBot.build(:book, isbn: nil)
    book.invalid?
    expect(book.errors[:isbn]).to include("can't be blank")
  end
  
  # ISBNが13文字のとき有効な状態であること
  it "is valid when an isbn is 13 characters" do
    book = FactoryBot.build(:book, isbn: "a" * 13)
    expect(book).to be_valid
  end
  
  # ISBNが14文字のとき無効な状態であること
  it "is invalid when an isbn is 14 characters" do
    book = FactoryBot.build(:book, isbn: "a" * 14)
    book.invalid?
    expect(book.errors[:isbn]).to include("is too long (maximum is 13 characters)")
  end
  
  # URLがなければ無効な状態であること
  it "is invalid without a url" do
    book = FactoryBot.build(:book, url: nil)
    book.invalid?
    expect(book.errors[:url]).to include("can't be blank")
  end
  
   # URLが255文字のとき有効な状態であること
  it "is valid when a url is 255 characters" do
    book = FactoryBot.build(:book, url: @char255)
    expect(book).to be_valid
  end
  
  # URLが256文字のとき無効な状態であること
  it "is invalid when a url is 256 characters" do
    book = FactoryBot.build(:book, url: @char256)
    book.invalid?
    expect(book.errors[:url]).to include("is too long (maximum is 255 characters)")
  end
  
   # 画像URLがなければ無効な状態であること
  it "is invalid without a image_url" do
    book = FactoryBot.build(:book, image_url: nil)
    book.invalid?
    expect(book.errors[:image_url]).to include("can't be blank")
  end
  
  # 画像URLが255文字のとき有効な状態であること
  it "is valid when a image_url is 255 characters" do
    book = FactoryBot.build(:book, image_url: @char255)
    expect(book).to be_valid
  end
  
  # 画層URLが256文字のとき無効な状態であること
  it "is invalid when a image_url is 256 characters" do
    book = FactoryBot.build(:book, image_url: @char256)
    book.invalid?
    expect(book.errors[:image_url]).to include("is too long (maximum is 255 characters)")
  end
  
  # カテゴリがなければ無効な状態であること
  it "is invalid without a category" do
    book = FactoryBot.build(:book, category: nil)
    book.invalid?
    expect(book.errors[:category]).to include("can't be blank")
  end
  
  # カテゴリが255文字のとき有効な状態であること
  it "is valid when a category is 255 characters" do
    book = FactoryBot.build(:book, category: @char255)
    expect(book).to be_valid
  end
  
  # カテゴリが256文字のとき無効な状態であること
  it "is invalid when a category is 256 characters" do
    book = FactoryBot.build(:book, category: @char256)
    book.invalid?
    expect(book.errors[:category]).to include("is too long (maximum is 255 characters)")
  end
end