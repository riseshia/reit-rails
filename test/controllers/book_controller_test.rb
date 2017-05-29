# frozen_string_literal: true

require "test_helper"

class BookControllerTest < ActionDispatch::IntegrationTest
  test "redirect to session/new" do
    get root_url
    assert_redirected_to new_user_session_path
  end

  test "render page" do
    sign_in users(:shia)
    get root_url
    assert_response :success
  end
end
