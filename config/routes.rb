# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :categories
      resources :materials

      resources :feed, only: [] do
        post :parse, on: :collection
      end
    end
  end
end
