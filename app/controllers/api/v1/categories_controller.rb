# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ActionController::API
      before_action :find_category, only: %i[update destroy show]

      def index
        @categories = Category.all
        render json: { success: true, categories: @categories.pluck(:title) }, status: :ok
      end

      def show
        render json: { success: true, category: @category.title, materials: @category.materials }, status: :ok
      end

      def create
        if params[:title].blank? || Category.where(title: params[:title]).exists?
          render json: { success: false }, status: :unprocessable_entity
        else
          @category = Category.create!(category_params)
          render json: { success: true, category: @category.title }, status: :ok
        end
      end

      def update
        if params[:title].blank? || Category.where(title: params[:title]).exists?
          render json: { success: false }, status: :unprocessable_entity
        else
          @category.update(category_params)
          render json: { success: true, category: @category.title }, status: :ok
        end
      end

      def destroy
        if @category.destroy
          render json: { success: true }, status: :ok
        else
          render json: { success: false }, status: :unprocessable_entity
        end
      end

      private

      def category_params
        params.permit(:title)
      end

      def find_category
        @category = Category.find_by(id: params[:id])
        render json: { success: false }, status: :not_found unless @category
      end
    end
  end
end
