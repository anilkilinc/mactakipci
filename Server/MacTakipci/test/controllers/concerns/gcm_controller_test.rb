require 'test_helper'

class Concerns::GcmControllerTest < ActionController::TestCase
  test "should get register," do
    get :register,
    assert_response :success
  end

  test "should get send_message" do
    get :send_message
    assert_response :success
  end

end
