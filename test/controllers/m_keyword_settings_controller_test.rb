require "test_helper"

class MKeywordSettingsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get m_keyword_settings_index_url
    assert_response :success
  end
end
