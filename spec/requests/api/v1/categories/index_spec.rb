# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GET api/v1/categories', type: :request do
  subject { response }

  context 'with categories' do
    let!(:categories) { create_list :category, 5 }

    before(:each) { get '/api/v1/categories' }

    it { is_expected.to have_http_status(:ok) }

    context 'with response body' do
      subject { JSON.parse(response.body) }

      it { is_expected.to eq('success' => true, 'categories' => categories.pluck(:title)) }
    end
  end
end
