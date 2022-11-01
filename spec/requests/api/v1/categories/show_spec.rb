# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET api/v1/categories/:id', type: :request do
  subject { response }

  context 'with category' do
    let!(:category) { create :category }
    let!(:material) { create :material, categories: [category] }

    before(:each) { get "/api/v1/categories/#{category.id}" }

    it { is_expected.to have_http_status(:ok) }

    context 'with response body' do
      subject { JSON.parse(response.body) }

      it 'returns category with materials' do
        is_expected.to eq(
          'success' => true,
          'category' => category.title,
          'materials' => [JSON.parse(material.to_json)]
        )
      end
    end

    context 'without category' do
      before(:each) { get '/api/v1/categories/0' }

      it { is_expected.to have_http_status(:not_found) }

      context 'with error' do
        subject { JSON.parse(response.body) }

        it { is_expected.to eq('success' => false) }
      end
    end
  end
end
