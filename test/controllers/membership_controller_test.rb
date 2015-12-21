require 'test_helper'

class MembershipControllerTest < ActionController::TestCase
  test "should get upgrade_membership" do
    get :upgrade_membership
    assert_response :success
  end
end
