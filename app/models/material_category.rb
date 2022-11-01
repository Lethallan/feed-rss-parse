# frozen_string_literal: true

class MaterialCategory < ApplicationRecord
  belongs_to :material
  belongs_to :category
end
