require "test_helper"

class TemplateWysiwygsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get template_wysiwygs_index_url
    assert_response :success
  end
end
