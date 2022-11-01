# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PUT api/v1/materials/:id', type: :request do
  subject { response }

  context 'with correct params' do
    let(:material) { create :material, categories: categories }
    let(:categories) { create_list :category, 3 }
    let(:new_categories) { %w[foo bar baz] }

    let!(:material_params) do
      {
        title: Faker::Lorem.sentence,
        link: "https://#{Faker::Lorem.word}-link.test/#{Faker::Lorem.word}",
        pub_date: Time.now,
        description: Faker::Lorem.paragraph,
        creator: Faker::Games::ElderScrolls.name,
        categories: new_categories
      }
    end

    before(:each) { put "/api/v1/materials/#{material.id}", params: material_params }

    it { is_expected.to have_http_status(:ok) }

    context 'with updated material' do
      subject { JSON.parse(response.body) }

      it 'returns material' do
        is_expected.to eq(
          'success' => true,
          'material' => JSON.parse(Material.last.to_json),
          'categories' => new_categories
        )
      end
    end
  end

  context 'without title' do
    let!(:material) { create :material }

    before(:each) { put "/api/v1/materials/#{material.id}" }

    it { is_expected.to have_http_status(:unprocessable_entity) }

    context 'with error' do
      subject { JSON.parse(response.body) }

      it { is_expected.to eq('success' => false) }
    end
  end

  context 'with existing link' do
    let!(:material) { create :material }
    let!(:other_material) { create :material, link: 'https://hello.test' }

    before(:each) { put "/api/v1/materials/#{material.id}?title=Foo&link=https://hello.test" }

    it { is_expected.to have_http_status(:unprocessable_entity) }

    context 'with error' do
      subject { JSON.parse(response.body) }

      it { is_expected.to eq('success' => false) }
    end
  end
end
