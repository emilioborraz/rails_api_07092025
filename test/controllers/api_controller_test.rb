require "test_helper"

class ApiControllerTest < ActionDispatch::IntegrationTest
  test "should get health" do
    get api_health_url
    assert_response :success
  end
end
