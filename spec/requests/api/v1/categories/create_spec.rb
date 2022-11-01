# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST api/v1/categories', type: :request do
  subject { response }

  context 'with correct params' do
    before(:each) { post "/api/v1/categories?title=#{title}" }

    let!(:title) { Faker::Lorem.sentence }

    it { is_expected.to have_http_status(:ok) }

    context 'with new category' do
      subject { JSON.parse(response.body) }

      it { is_expected.to eq('success' => true, 'category' => Category.last.title) }
    end
  end

  context 'without title' do
    before(:each) { post '/api/v1/categories' }

    it { is_expected.to have_http_status(:unprocessable_entity) }

    context 'with error' do
      subject { JSON.parse(response.body) }

      it { is_expected.to eq('success' => false) }
    end
  end

  context 'with existing title' do
    let!(:category) { create :category, title: 'Hello' }

    before(:each) { post '/api/v1/categories?title=Hello' }

    it { is_expected.to have_http_status(:unprocessable_entity) }

    context 'with error' do
      subject { JSON.parse(response.body) }

      it { is_expected.to eq('success' => false) }
    end
  end
end
