# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'PUT api/v1/categories/:id', type: :request do
  subject { response }

  let!(:category) { create :category }

  context 'with correct params' do
    before(:each) { put "/api/v1/categories/#{category.id}?title=Hello" }

    it { is_expected.to have_http_status(:ok) }

    context 'with new category' do
      subject { JSON.parse(response.body) }

      it { is_expected.to eq('success' => true, 'category' => Category.last.title) }
    end
  end

  context 'without title' do
    before(:each) { put "/api/v1/categories/#{category.id}" }

    it { is_expected.to have_http_status(:unprocessable_entity) }

    context 'with error' do
      subject { JSON.parse(response.body) }

      it { is_expected.to eq('success' => false) }
    end
  end

  context 'with existing title' do
    let!(:other_category) { create :category, title: 'Oops' }

    before(:each) { put "/api/v1/categories/#{category.id}?title=Oops" }

    it { is_expected.to have_http_status(:unprocessable_entity) }

    context 'with error' do
      subject { JSON.parse(response.body) }

      it { is_expected.to eq('success' => false) }
    end
  end
end
