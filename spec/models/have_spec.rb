require 'rails_helper'

RSpec.describe Have, type: :model do
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
  # ユーザ、ブックがあれば有効な状態であること
  it "is valid with a user and book" do
    have = Have.new(
      user: @user,
      book: @book
    )
    expect(have).to be_valid
  end
end
