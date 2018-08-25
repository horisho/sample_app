require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: {
          user: {
              name: "", email: "user@invalid.com",
              password: "foobar", password_confirmation: "foobar"
            }
        }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.field_with_errors'
    assert_select  'form[action="/signup"]'
  end

  test "valid signup information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post users_path, params: {
          user: {
              name: "Example User", email: "valid@example.com",
              password: "foobar", password_confirmation: "foobar"
            }
        }
      end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.blank?
  end
end