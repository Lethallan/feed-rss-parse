# frozen_string_literal: true

class ParseService
  include HTTParty

  def call(items)
    items.each do |item|
      data = item.children.children.to_a
      material_params = material_params(data)

      CreateMaterialJob.perform_later(material_params)
    end
  end

  private

  def material_params(data)
    {
      title: data.first.text,
      link: data[2]&.text,
      pub_date: data[4]&.text&.to_datetime,
      description: description(data[3]),
      creator: data[5]&.text,
      categories: data[6..].map(&:text)
    }
  end

  def description(text)
    Nokogiri::HTML(text.to_s).css('p').text
  end
end
