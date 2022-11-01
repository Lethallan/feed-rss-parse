# frozen_string_literal: true

class ParseJob < ApplicationJob
  queue_with_priority 1
  queue_as :parse

  def perform(link)
    return unless link

    page = HTTParty.get(link)
    items = Nokogiri::XML(page.body).css('item').to_a

    ParseService.new.call(items)
  end
end
