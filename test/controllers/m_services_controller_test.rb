require "test_helper"

class MServicesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get m_services_index_url
    assert_response :success
  end
end
