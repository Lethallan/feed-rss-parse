# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE api/v1/categories/:id', type: :request do
  subject { response }

  context 'with category' do
    let!(:category) { create :category }

    before(:each) { delete "/api/v1/categories/#{category.id}" }

    it { is_expected.to have_http_status(:ok) }

    context 'with response body' do
      subject { JSON.parse(response.body) }

      it { is_expected.to eq('success' => true) }
    end
  end

  context 'with material' do
    let!(:category) { create :category }
    let!(:other_category) { create :category }
    let!(:material) { create :material, categories: [category, other_category] }

    it 'does not delete material' do
      expect { delete "/api/v1/categories/#{category.id}" }.not_to change { Material.count }.from(1)
    end

    it 'destroys relations' do
      expect { delete "/api/v1/categories/#{category.id}" }.to change { MaterialCategory.count }.from(2).to(1)
    end
  end

  context 'without category' do
    before(:each) { delete '/api/v1/categories/0' }

    it { is_expected.to have_http_status(:not_found) }

    context 'with response body' do
      subject { JSON.parse(response.body) }

      it { is_expected.to eq('success' => false) }
    end
  end
end
