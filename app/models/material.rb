# frozen_string_literal: true

class Material < ApplicationRecord
  has_many :material_categories, dependent: :destroy
  has_many :categories, through: :material_categories

  validates :title, presence: true
  validates :link, presence: true, uniqueness: true, format: %r{https://[-a-z0-9]+.[a-z]+/{0,1}\S*}
end
