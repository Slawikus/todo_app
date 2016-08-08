require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user         = User.create!(username: "Slawa", password: "password")
    @another_user = User.create!(username: "Mike",  password: "password")

    @header = { "Content-Type" => "application/json", "Authorization" => "Token token=" + @user.token }
  end

  test "should not get anywhere without authentication" do
    get users_path
    assert_response :unauthorized
    get user_path(@user)
    assert_response :unauthorized
  end

  test "should get all users when authenticated" do
    get users_path, headers: @header
    assert_response :success
  end

  test "should get current user when authenticated" do
    get user_path(@user), headers: @header
    assert_response :success
    assert_match @user.username, @response.body
  end

  test "should not get another user when authenticated" do
    get user_path(@another_user), headers: @header
    assert_response :unauthorized
  end

  test "should create user not authenticated" do
    post users_path, params: { user: { username: "Alice", password: "password" } }
    assert_response :created
  end

  test "should update user authenticated" do
    new_password = "new_password"
    patch user_path(@user), headers: @header, params: { user: { password: new_password } }, as: :json
    assert_response :success
    @user.reload
    assert @user.authenticate(new_password)
  end

  test "should delete user when authenticated" do
    delete user_path(@user), headers: @header
    assert_response :no_content
  end

  test "should not delete another user when authenticated" do
    delete user_path(@another_user), headers: @header
    assert_response :unauthorized
  end

end
