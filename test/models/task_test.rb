require 'test_helper'

class TaskTest < ActiveSupport::TestCase

  def setup
    @user = User.create!(username: "Slawa", password: "password")
    @task = @user.tasks.build(title: "Some task")
  end

  test "should be valid" do
    assert @task.valid?
  end

  test "title should be present" do
    @task.title = " "
    assert_not @task.valid?
  end

  test "title should be at most 50 characters" do
    @task.title = "a" * 51
    assert_not @task.valid?
  end

  test "user id should be present" do
    @task.user_id = nil
    assert_not @task.valid?
  end

  test "should be associated to user" do
    @task.save
    assert @task.user_id == @user.id
  end

end
