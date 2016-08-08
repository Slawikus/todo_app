require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "Slawa", password: "password")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should be present" do
    @user.username = " "
    assert_not @user.valid?
  end

  test "username should not be too long" do
    @user.username = "a" * 21
    assert_not @user.valid?
  end

  test "username should be unique" do
    duplicate_user = @user.dup
    duplicate_user.username = @user.username
    @user.save
    assert_not duplicate_user.valid?
  end

  test "password should be present" do
    @user.password = " "
    assert_not @user.valid?
  end

  test "gets an authorization token" do
    @user.save
    assert @user.token
  end

  test "can authenticate" do
    @user.save
    assert @user.authenticate(@user.password)
  end

  test "can create tasks" do
    @user.save
    assert_difference 'Task.count', +1 do
      @user.tasks.create!(title: "Some task")
    end
  end

  test "associated tasks should be destroyed" do
    @user.save
    @user.tasks.create!(title: "Some task")
    assert_difference 'Task.count', -1 do
      @user.destroy
    end
  end

end
