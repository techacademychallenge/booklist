FactoryBot.define do
  factory :post do
    association :user
    association :book
    content "content"
  end
end
