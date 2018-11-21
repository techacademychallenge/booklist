require 'rails_helper'

RSpec.describe User, type: :model do
  # 有効なファクトリを持つこと
  it "has a valid factory" do
    expect(FactoryBot.build(:user)).to be_valid
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
    user = FactoryBot.build(:user, name: nil)
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end
  
  # 名前が50文字のとき有効な状態であること
  it "is valid when a name is 50 characters" do
    user = FactoryBot.build(:user, name: "a" * 50)
    expect(user).to be_valid
  end
  
  # 名前が51文字のとき無効な状態であること
  it "is invalid when a name is 51 characters" do
    user = FactoryBot.build(:user, name: "a" * 51)
    user.valid?
    expect(user.errors[:name]).to include("is too long (maximum is 50 characters)")
  end
  
  # メールアドレスがなければ無効な状態であること
  it "is invalid without an email address" do
    user = FactoryBot.build(:user, email: nil)
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end
  
  # メールアドレスが255文字のとき有効な状態であること
  it "is valid when an email address is 255 characters" do
    user = FactoryBot.build(:user, email: "a" * 243 + "@example.com")
    expect(user).to be_valid
  end
  
  # メールアドレスが256文字であれば無効な状態であること
  it "is invalid when an email address 256 characters" do
    user = FactoryBot.build(:user, email: "a" * 244 + "@example.com")
    user.valid?
    expect(user.errors[:email]).to include("is too long (maximum is 255 characters)")
  end
  
  # 誤ったフォーマットのメールアドレスなら無効な状態であること
  it "is invalid when a wrong email address" do
    user = FactoryBot.build(:user, email: "12345")
    user.valid?
    expect(user.errors[:email]).to include("is invalid")
  end
  
  # 重複したメールアドレスなら無効な状態であること
  it "is invalid with a duplicate email address" do
    FactoryBot.create(:user, email: "test@test.com")
    other_user = FactoryBot.build(:user, email: "test@test.com")
    other_user.valid?
    expect(other_user.errors[:email]).to include("has already been taken")
  end

  # パスワードとパスワード確認に過りがあったなら無効な状態であること
  it "is invalid a different password and password_confirmation" do
    user = FactoryBot.build(:user, password_confirmation: "miss_password")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end
  
  # 本が追加された結果が返却されること
  it "returns books have been added" do
    user = FactoryBot.create(:user)
    book = FactoryBot.create(:book)
    user.add(book)
    expect(user.books).to include(book)
  end
  
  # 削除された本が含まれていない結果が返却されること
  it "returns not include delete book" do
    have = FactoryBot.create(:have)
    user = have.user
    book = have.book
    user.remove(book)
    expect(user.books).to_not include(book)
  end
 
  # 一致する本を持っているとき 
  context "when have a book" do
    # trueを返すこと
    it "returns true" do
      have = FactoryBot.create(:have)
      user = have.user
      book = have.book
      expect(user.have?(book)).to eq true
    end
  end
  
  # 別の本を持っているとき
  context "when have a another book " do
    # falseを返すこと
    it "returns false" do
      have = FactoryBot.create(:have)
      user = have.user
      another_book = FactoryBot.create(:book)
      expect(user.have?(another_book)).to eq false
    end
  end
end