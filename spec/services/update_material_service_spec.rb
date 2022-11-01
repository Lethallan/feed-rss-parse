# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdateMaterialService do
  let!(:material) { create :material, title: '123', description: 'aaa' }
  let!(:initial_categories) { material.categories.pluck(:title) }
  let!(:titles) { %w[foo bar baz] }
  let!(:material_params) { { description: 'Lorem ipsum', categories: titles } }

  context 'with new records' do
    subject { UpdateMaterialService.new(material, material_params).call }

    it { expect { subject }.to change { material.description }.from('aaa').to('Lorem ipsum') }
    it { expect { subject }.to change { material.categories.pluck(:title) }.from(initial_categories).to(%w[foo bar baz]) }
    it { expect { subject }.to_not change { material.title }.from('123') }
  end
end
