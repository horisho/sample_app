require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: {
        name: "", email: "foo@invalid", 
        password: "foo", password_confirmation: "bar"
      }}
    assert_template 'users/edit'
    assert_select 'div.alert', text: "The form contains 4 errors."
  end

  test "successful edit" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: {
        name: "Foo Bar", email: "foo@bar.com",
        password: "", password_confirmation: ""
      }}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal @user.name, "Foo Bar"
    assert_equal @user.email, "foo@bar.com"
#    assert_template 'users/#{@user.id}'
  end
end
