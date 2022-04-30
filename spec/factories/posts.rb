# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    title { Faker::Name.name }
    body { Faker::Lorem.sentence }
    author { user }
  end
end
