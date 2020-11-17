require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:anon)
  end
  
  test "login with invalid information" do
    get login_path
    assert_template 'users/sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'users/sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "login with valid information" do
    get login_path
    assert_template 'users/sessions/new'
    post login_path, params: { session: { email: "anon@example.com", password: "password" } }
    assert_redirected_to root_url
    assert_not flash.empty?
  end
end
