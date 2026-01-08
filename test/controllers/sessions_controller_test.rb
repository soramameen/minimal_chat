require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should set user name in session" do
    post set_name_url, params: { user_name: "Alice" }
    assert_redirected_to root_path
    assert_equal "Alice", session[:user_name]
  end
end
