require 'test_helper'

class TestControllerTest < ActionController::TestCase
  test "should get gcm_register_test" do
    get :gcm_register_test
    assert_response :success
  end

end
