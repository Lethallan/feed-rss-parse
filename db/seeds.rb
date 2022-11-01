# frozen_string_literal: true

Category.create!(
  [
    { title: Faker::Games::ElderScrolls.jewelry },
    { title: Faker::Games::ElderScrolls.dragon },
    { title: Faker::Games::ElderScrolls.city }
  ]
)

Material.create!(
  [
    {
      title: Faker::Lorem.sentence,
      link: "https://#{Faker::Lorem.word}-link.test/#{Faker::Lorem.word}",
      pub_date: Time.now,
      description: Faker::Lorem.paragraph,
      creator: Faker::Games::ElderScrolls.name,
      categories: Category.where(id: [1, 2])
    },
    {
      title: Faker::Lorem.sentence,
      link: "https://#{Faker::Lorem.word}-link.test/#{Faker::Lorem.word}",
      pub_date: Time.now,
      description: Faker::Lorem.paragraph,
      creator: Faker::Games::ElderScrolls.name,
      categories: Category.where(id: [2, 3])
    },
    {
      title: Faker::Lorem.sentence,
      link: "https://#{Faker::Lorem.word}-link.test/#{Faker::Lorem.word}",
      pub_date: Time.now,
      description: Faker::Lorem.paragraph,
      creator: Faker::Games::ElderScrolls.name,
      categories: Category.where(id: 3)
    }
  ]
)
