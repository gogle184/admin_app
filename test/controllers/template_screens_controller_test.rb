require "test_helper"

class TemplateScreensControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get template_screens_index_url
    assert_response :success
  end
end
