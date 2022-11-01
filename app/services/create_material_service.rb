# frozen_string_literal: true

class CreateMaterialService
  def initialize(material_params)
    @data = material_params
    @titles = material_params[:categories]
  end

  def call
    return if Material.where(link: @data[:link]).exists?

    all_categories = @titles&.map { |title| Category.find_or_create_by!(title: title) }

    Material.create!(
      title: @data[:title],
      link: @data[:link],
      pub_date: @data[:pub_date],
      description: @data[:description],
      creator: @data[:creator],
      categories: all_categories
    )
  end
end
