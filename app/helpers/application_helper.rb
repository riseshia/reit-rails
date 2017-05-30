# frozen_string_literal: true

module ApplicationHelper
  def markdown(str)
    raw(Kramdown::Document.new(str).to_html)
  end
end
