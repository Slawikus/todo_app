require 'test_helper'

class LoginControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user         = User.create!(username: "Slawa", password: "password")

    @header = { "Content-Type" => "application/json", "Authorization" => "Token token=" + @user.token }
  end

  test "should login with valid credentials" do
    post login_path, params: { user: { username: @user.username, password: @user.password } }, as: :json
    assert_response :success
    assert_match @user.token, @response.body
  end

  test "should not login with invalid credentials" do
    post login_path, params: { user: { username: "SomeLogin", password: "somepassword" } }, as: :json
    assert_response :forbidden
    assert_no_match @user.token, @response.body
  end

end
