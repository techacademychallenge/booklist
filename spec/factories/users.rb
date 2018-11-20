FactoryBot.define do
  factory :user do
    name "Aaron Sumner"
    sequence(:email) { |n| "tester#{n}@example.com" }
    password "dottle-nouveau-pavilion-tights-furze"
    password_confirmation "dottle-nouveau-pavilion-tights-furze"  
  end
end
