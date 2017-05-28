# frozen_string_literal: true

require "test_helper"

class BookControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get root_url
    assert_response :success
  end
end
