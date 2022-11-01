# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET api/v1/maaterials/:id', type: :request do
  subject { response }

  context 'with category' do
    let!(:categories) { create_list :category, 5 }
    let!(:material) { create :material, categories: categories }

    before(:each) { get "/api/v1/materials/#{material.id}" }

    it { is_expected.to have_http_status(:ok) }

    context 'with response body' do
      subject { JSON.parse(response.body) }

      it 'returns material' do
        is_expected.to eq(
          'success' => true,
          'material' => JSON.parse(material.to_json),
          'categories' => categories.pluck(:title)
        )
      end
    end

    context 'without material' do
      before(:each) { get '/api/v1/materials/0' }

      it { is_expected.to have_http_status(:not_found) }

      context 'with error' do
        subject { JSON.parse(response.body) }

        it { is_expected.to eq('success' => false) }
      end
    end
  end
end
