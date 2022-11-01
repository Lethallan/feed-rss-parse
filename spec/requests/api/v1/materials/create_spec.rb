# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST api/v1/materials', type: :request do
  subject { response }

  context 'with correct params' do
    let(:existing_categories) { create_list :category, 3 }
    let(:new_categories) { %w[foo bar baz] }
    let(:all_categories) { existing_categories.pluck(:title) + new_categories }

    let!(:material_params) do
      {
        title: Faker::Lorem.sentence,
        link: "https://#{Faker::Lorem.word}-link.test/#{Faker::Lorem.word}",
        pub_date: Time.now,
        creator: Faker::Games::ElderScrolls.name,
        description: Faker::Lorem.paragraph,
        categories: all_categories
      }
    end

    before(:each) { post '/api/v1/materials', params: material_params }

    it { is_expected.to have_http_status(:ok) }

    context 'with new material' do
      subject { JSON.parse(response.body) }

      it 'returns material' do
        is_expected.to eq(
          'success' => true,
          'material' => JSON.parse(Material.last.to_json),
          'categories' => all_categories
        )
      end
    end
  end

  context 'without title' do
    before(:each) { post '/api/v1/materials' }

    it { is_expected.to have_http_status(:unprocessable_entity) }

    context 'with error' do
      subject { JSON.parse(response.body) }

      it { is_expected.to eq('success' => false) }
    end
  end

  context 'with existing link' do
    let!(:material) { create :material, link: 'https://hello.test' }

    before(:each) { post '/api/v1/materials?title=Foo&link=https://hello.test' }

    it { is_expected.to have_http_status(:unprocessable_entity) }

    context 'with error' do
      subject { JSON.parse(response.body) }

      it { is_expected.to eq('success' => false) }
    end
  end
end
