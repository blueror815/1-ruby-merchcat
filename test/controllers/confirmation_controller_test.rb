require 'test_helper'

class ConfirmationControllerTest < ActionController::TestCase
  test "should get send_confirmation" do
    get :send_confirmation
    assert_response :success
  end

end
