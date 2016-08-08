require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "Slawa", password: "password")
  end

  test "password should be present" do
    @user.password = ' '
    assert_not @user.valid?
  end
end
