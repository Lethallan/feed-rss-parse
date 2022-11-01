# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'DELETE api/v1/materials/:id', type: :request do
  subject { response }

  context 'with category' do
    let!(:material) { create :material }

    before(:each) { delete "/api/v1/materials/#{material.id}" }

    it { is_expected.to have_http_status(:ok) }

    context 'with response body' do
      subject { JSON.parse(response.body) }

      it { is_expected.to eq('success' => true) }
    end
  end

  context 'with categories' do
    let!(:material) { create :material }

    it 'does not delete category' do
      expect { delete "/api/v1/materials/#{material.id}" }.not_to change { Category.count }.from(2)
    end

    it 'destroys relations' do
      expect { delete "/api/v1/materials/#{material.id}" }.to change { MaterialCategory.count }.from(2).to(0)
    end
  end

  context 'without category' do
    before(:each) { delete '/api/v1/materials/0' }

    it { is_expected.to have_http_status(:not_found) }

    context 'with response body' do
      subject { JSON.parse(response.body) }

      it { is_expected.to eq('success' => false) }
    end
  end
end
