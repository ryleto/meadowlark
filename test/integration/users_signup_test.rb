require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: "",
                               email: "invalid@user",
                               password: "wrong",
                               password_confirmation: "wrongagain" }
    end
    assert_template 'users/new'                           
  end
end
