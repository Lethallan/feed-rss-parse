# frozen_string_literal: true

FactoryBot.define do
  factory :material do
    title { Faker::Lorem.sentence }
    link { "https://#{Faker::Lorem.word}-link.test/#{Faker::Lorem.word}" }
    pub_date { Time.now }
    description { Faker::Lorem.paragraph }
    creator { Faker::Games::ElderScrolls.name }
    categories { create_list :category, 2 }
  end
end
