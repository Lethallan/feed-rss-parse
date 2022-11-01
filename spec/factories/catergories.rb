# frozen_string_literal: true

FactoryBot.define do
  factory :category do
    title { Faker::Lorem.sentence }
  end
end
