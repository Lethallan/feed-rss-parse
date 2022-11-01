# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET api/v1/material', type: :request do
  subject { response }

  context 'with categories' do
    let!(:materials) { create_list :material, 5 }

    before(:each) { get '/api/v1/materials' }

    it { is_expected.to have_http_status(:ok) }

    context 'with response body' do
      let(:materials_response) do
        materials.map { |material| { item: material, categories: material.categories.pluck(:title) } }
      end

      subject { JSON.parse(response.body) }

      it { is_expected.to eq('success' => true, 'materials' => JSON.parse(materials_response.to_json)) }
    end
  end
end
