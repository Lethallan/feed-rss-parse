# frozen_string_literal: true

class UpdateMaterialService
  def initialize(material, material_params)
    @material = material
    @data = material_params.to_h.without(:categories)
    @titles = material_params[:categories]
  end

  def call
    @material.update(@data)
    update_categories
  end

  def update_categories
    return unless @titles

    categories = @titles.map { |title| Category.find_or_create_by!(title: title) }
    @material.update(categories: categories)
  end
end
