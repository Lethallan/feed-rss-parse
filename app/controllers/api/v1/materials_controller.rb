# frozen_string_literal: true

module Api
  module V1
    class MaterialsController < ActionController::API
      before_action :find_material, only: %i[update destroy show]

      def index
        @materials = Material.includes(:categories).all
        render json: {
          success: true,
          materials: @materials.map { |material| { item: material, categories: material.categories.pluck(:title) } }
        }, status: :ok
      end

      def show
        render json: { success: true, material: @material, categories: @material.categories.pluck(:title) }, status: :ok
      end

      def create
        if params[:title].blank? || Material.where(link: params[:link]).exists?
          render json: { success: false }, status: :unprocessable_entity
        else
          @material = CreateMaterialService.new(material_params).call
          render json: { success: true, material: @material, categories: @material.categories.pluck(:title) }, status: :ok
        end
      end

      def update
        if params[:title].blank? || Material.where(link: params[:link]).exists?
          render json: { success: false }, status: :unprocessable_entity
        else
          UpdateMaterialService.new(@material, material_params).call
          render json: { success: true, material: @material, categories: @material.categories.pluck(:title) }, status: :ok
        end
      end

      def destroy
        if @material.destroy
          render json: { success: true }, status: :ok
        else
          render json: { success: false }, status: :unprocessable_entity
        end
      end

      private

      def material_params
        params.permit(
          :title,
          :link,
          :pub_date,
          :description,
          :creator,
          categories: []
        )
      end

      def find_material
        @material = Material.find_by(id: params[:id])
        render json: { success: false }, status: :not_found unless @material
      end
    end
  end
end
