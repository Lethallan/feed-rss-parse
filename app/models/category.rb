# frozen_string_literal: true

class Category < ApplicationRecord
  has_many :material_categories, dependent: :destroy
  has_many :materials, through: :material_categories

  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
