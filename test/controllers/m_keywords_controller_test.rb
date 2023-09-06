require "test_helper"

class MKeywordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get m_keywords_index_url
    assert_response :success
  end
end
