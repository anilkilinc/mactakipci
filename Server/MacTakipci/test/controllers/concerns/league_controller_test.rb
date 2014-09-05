require 'test_helper'

class Concerns::LeagueControllerTest < ActionController::TestCase
  test "should get create" do
    get :create
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get list" do
    get :list
    assert_response :success
  end

end
