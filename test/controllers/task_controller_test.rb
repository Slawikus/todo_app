require 'test_helper'

class TaskControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user         = User.create!(username: "Slawa", password: "password")
    @another_user = User.create!(username: "Mike",  password: "password")

    @task         = @user.tasks.create!(title: "User task")
    @another_task = @another_user.tasks.create!(title: "Another user task")

    @header = { "Content-Type" => "application/json", "Authorization" => "Token token=" + @user.token }
  end

  test "should not get anywhere without authentication" do
    get tasks_path
    assert_response :unauthorized
    get task_path(@task)
    assert_response :unauthorized
  end

  test "should get all user tasks when authenticated" do
    get tasks_path, headers: @header
    assert_response :success
    assert_match @task.title, @response.body
  end

  test "should not get other user tasks when authenticated" do
    get tasks_path, headers: @header
    assert_response :success
    assert_no_match @another_task.title, @response.body
  end

  test "should get current user task when authenticated" do
    get task_path(@task), headers: @header
    assert_response :success
    assert_match @task.title, @response.body
  end

  test "should not get another users task when authenticated" do
    get task_path(@another_task), headers: @header
    assert_response :unauthorized
  end

  test "should not create task not authenticated" do
    post tasks_path, params: { title: "Some title" }
    assert_response :unauthorized
  end

  test "should create task authenticated" do
    post tasks_path, params: { title: "Some title" }, headers: @header, as: :json
    assert_response :created
  end

  test "should update task authenticated" do
    new_title = "Some new title"
    patch task_path(@task), params: { title: new_title }, headers: @header, as: :json
    assert_response :success
    assert_match new_title, @response.body
  end

  test "should delete task user when authenticated" do
    delete task_path(@task), headers: @header
    assert_response :no_content
  end

  test "should not delete another users task when authenticated" do
    delete user_path(@another_task), headers: @header
    assert_response :unauthorized
  end

end
