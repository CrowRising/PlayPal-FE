# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { Faker::Name.first_name }
    email { Faker::Internet.email }
    token { Faker::Number.number(digits: 10) }
    google_id { Faker::Number.number(digits: 10) }
  end
end
