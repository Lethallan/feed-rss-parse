# frozen_string_literal: true

class CreateMaterialJob < ApplicationJob
  queue_with_priority 2
  queue_as :materials

  def perform(material_params)
    CreateMaterialService.new(material_params).call
  end
end
