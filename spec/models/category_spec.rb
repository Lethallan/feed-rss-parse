# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  context 'associations' do
    it { should have_many(:materials).through(:material_categories) }
  end

  context 'validations' do
    it { should validate_presence_of :title }

    context 'unique title' do
      subject { build(:category) }

      it { should validate_uniqueness_of(:title).case_insensitive }
    end
  end
end
