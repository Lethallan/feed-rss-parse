# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ParseService do
  include ActiveJob::TestHelper

  let(:items) { Nokogiri::XML(File.read('spec/fixtures/page.xml')).css('item').to_a }

  context 'with new job' do
    let(:item) { items.first }

    let(:titles) do
      ['ReactJS',
       'TypeScript',
       'Менеджер состояний',
       'react',
       'type',
       'хук']
    end

    let(:material_params) do
      {
        title: 'Как сделать свой собственный менеджер состояния в React всего с одним хуком',
        link: 'https://habr.com/ru/post/696660/?utm_source=habrahabrutm_medium=rssutm_campaign=696660',
        pub_date: 'Mon, 31 Oct 2022 23:21:10 GMT'.to_datetime,
        description: 'Представьте задачу, что вам нужно изменять состояние однотипных компонентов, затрагивающих только один из них. Нечто очень похожее можно реализовать с использованием контекста React. Но в этом случае мы рискуем получить повторный рендер на всех потребителях контекста, что не очень хорошо, если таких потребителей на странице одновременно довольно много.В этой заметке я постараюсь разобрать решение, которое позволяет изменять состояние только тех потребителей, которые необходимо изменить. Причем такое поведение будет обеспечено всего одним хуком.',
        creator: 'mordorhell',
        categories: titles
      }
    end

    before { ParseService.new.call([item]) }

    subject { CreateMaterialJob }

    it { is_expected.to have_been_enqueued.with(material_params) }
  end
end
