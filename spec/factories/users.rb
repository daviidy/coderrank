require 'faker'
FactoryBot.define do
  factory :user do
    name { Faker::Name.name }  # You can use the Faker gem for fake data
    email { Faker::Internet.email }
    password { 'password123' }  # Set a default password
    # Add any other attributes you want to set for the user here
  end
end
