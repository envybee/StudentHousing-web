require 'test_helper'

class ApiHousingListingControllerTest < ActionController::TestCase
  test "should get near" do
    get :near
    assert_response :success
  end

end
