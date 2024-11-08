# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    # name { "Test User" }
    email { Faker::Internet.unique.email }  # Ensure unique emails for each user
    password {"123456"}
    role { :member }  # Or set this according to your logic
  end
end
