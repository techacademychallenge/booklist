require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @new_user = User.new(
      name: "Aaron Sumner",
      email: "tester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
      password_confirmation: "dottle-nouveau-pavilion-tights-furze"
    )
    
    @create_user = User.create(
      name: "Aaron Sumner",
      email: "tester_create@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
      password_confirmation: "dottle-nouveau-pavilion-tights-furze"
    )
    
    @book1 = Book.create(
      title: "title1",
      author: "author1",
      isbn: "isbn1",
      url: "url1",
      image_url: "image_url1",
      category: "category1"
    )
    
    @book2 = Book.create(
      title: "title2",
      author: "author2",
      isbn: "isbn2",
      url: "url2",
      image_url: "image_url2",
      category: "category2"
    )
    
    @book3 = Book.create(
      title: "title3",
      author: "author3",
      isbn: "isbn3",
      url: "url3",
      image_url: "image_url3",
      category: "category3"
    )
      
  end
  
  # 名前、メール、パスワードがあれば有効な状態であること
  it "is valid with a name, email, and password and password_confirmation" do
    user = User.new(
      name: "Aaron Sumner",
      email: "tester@example.com",
      password: "dottle-nouveau-pavilion-tights-furze",
      password_confirmation: "dottle-nouveau-pavilion-tights-furze",
    )
    expect(user).to be_valid
  end
  
  # 名前がなければ無効な状態であること
  it "is invalid without a first name" do
    user = User.new(name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end
  
  # 名前が50文字のとき有効な状態であること
  it "is valid when a name is 50 characters" do
    @new_user.name = "a" * 50
    expect(@new_user).to be_valid
  end
  
  # 名前が51文字のとき無効な状態であること
  it "is invalid when a name is 51 characters" do
    user = User.new(name: "a" * 51)
    user.valid?
    expect(user.errors[:name]).to include("is too long (maximum is 50 characters)")
  end
  
  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  
  # メールアドレスが255文字のとき有効な状態であること
  it "is valid when an email address is 255 characters" do
    @new_user.email = "a" * 243 + "@example.com"
    expect(@new_user).to be_valid
  end
  
  # メールアドレスが256文字であれば無効な状態であること
  it "is invalid when an email address 256 characters" do
    user = User.new(email: "a" * 244 + "@example.com")
    user.valid?
    expect(user.errors[:email]).to include("is too long (maximum is 255 characters)")
  end
  
  # 誤ったフォーマットのメールアドレスなら無効な状態であること
  it "is invalid format a fail email address" do
    user = User.new(email: "12345")
    user.valid?
    expect(user.errors[:email]).to include("is invalid")
  end
  
  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    @new_user.save
    other_user = User.new(
      name: @new_user.name,
      email: @new_user.email,
      password: @new_user.password,
      password_confirmation: @new_user.password
    )
    other_user.valid?
    expect(other_user.errors[:email]).to include("has already been taken")
  end

  # パスワードとパスワード確認に過りがあったなら無効な状態であること
  it "is invalid a different password and password_confirmation" do
    @new_user.password_confirmation = "miss_password"
    @new_user.save
    expect(@new_user.errors[:password_confirmation]).to include("doesn't match Password")
  end
  
  # 本が追加された結果が返却されること
  it "returns books have been added" do
    @create_user.have(@book1)
    expect(@create_user.books).to include(@book1)
  end
  
  # 削除された本が含まれていない結果が返却されること
  it "returns not include delete book" do
    @create_user.have(@book1)
    @create_user.unhave(@book1)
    expect(@create_user.books).to_not include(@book1)
  end
 
  # 一致する本を持っているとき 
  context "when have a book" do
    # trueを返すこと
    it "returns true" do
      @create_user.have(@book1)
      expect(@create_user.have?(@book1)).to eq true
    end
  end
  
  # 別の本を持っているとき
  context "when have a another book " do
    # falseを返すこと
    it "returns false" do
      @create_user.have(@book2)
      expect(@create_user.have?(@book1)).to eq false
    end
  end
end