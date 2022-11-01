# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'POST api/v1/feed/parse', type: :request do
  include ActiveJob::TestHelper

  let!(:link) { "https://#{Faker::Lorem.word}-link.test/#{Faker::Lorem.word}" }

  subject { response }

  context 'with correct link format' do
    before(:each) { post "/api/v1/feed/parse?link=#{link}" }

    it { is_expected.to have_http_status(:ok) }

    context 'with response body' do
      subject { JSON.parse(response.body) }

      it { is_expected.to eq('success' => true) }
    end

    context 'with job' do
      subject { ParseJob }

      it{ is_expected.to have_been_enqueued.with(link) }
    end
  end

  context 'with wrong link format' do
    before(:each) { post '/api/v1/feed/parse?link=hello' }

    it { is_expected.to have_http_status(:unprocessable_entity) }

    context 'with response body' do
      subject { JSON.parse(response.body) }

      it { is_expected.to eq('success' => false) }
    end

    context 'with job' do
      subject { ParseJob }

      it{ is_expected.not_to have_been_enqueued }
    end
  end
end
