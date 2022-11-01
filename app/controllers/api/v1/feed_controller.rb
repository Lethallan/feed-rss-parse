# frozen_string_literal: true

module Api
  module V1
    class FeedController < ActionController::API
      def parse
        if params[:link].match?(%r{https://[-a-z0-9]+.[a-z]+/{0,1}\S*})
          ParseJob.perform_later(params[:link])
          render json: { success: true }, status: :ok
        else
          render json: { success: false }, status: :unprocessable_entity
        end
      end
    end
  end
end
