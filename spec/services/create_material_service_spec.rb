# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateMaterialService do
  let!(:existing_categories) { create_list :category, 3 }
  let!(:titles) { %w[foo bar baz] }
  let!(:material_params) do
    {
      title: Faker::Lorem.sentence,
      link: "https://#{Faker::Lorem.word}-link.test/#{Faker::Lorem.word}",
      pub_date: Time.now,
      creator: Faker::Games::ElderScrolls.name,
      description: Faker::Lorem.paragraph,
      categories: titles
    }
  end

  context 'with new records' do
    subject { CreateMaterialService.new(material_params).call }

    it { expect { subject }.to change { Material.count }.from(0).to(1) }
    it { expect { subject }.to change { Category.count }.from(3).to(6) }
  end
end
