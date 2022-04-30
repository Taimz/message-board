FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { Faker::Internet.email }
    about { Faker::Lorem.sentence }
    password { 'Pa$$word1!' }
    password_confirmation { 'Pa$$word1!' }
  end
end
