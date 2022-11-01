# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Material, type: :model do
  context 'associations' do
    it { should have_many(:categories).through(:material_categories) }
  end

  context 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :link }

    context 'unique link' do
      subject { build(:material) }

      it { should validate_uniqueness_of(:link) }
    end
  end
end
