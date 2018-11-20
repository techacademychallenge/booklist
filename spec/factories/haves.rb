FactoryBot.define do
  factory :have, class: 'Have' do
    association :user
    association :book
  end
end
