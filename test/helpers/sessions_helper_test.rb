require 'test_helper'

class SessionsHelperTest < ActionView::TestCase

  def setup
    @user = users(:michael)
    remember(@user)
  end

  test "current_user returns right user when session is nil" do
    assert_equal @user, current_user
    assert is_logged_in?
  end

  test "current_user returns nil when remember digest is wrong" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end

# 以下はredirect_toが使えないのでエラーを吐く

#  test "redirect_back_or returns given url and delete it" do
#    session[:forwarding_url] = user_path(@user)
#    redirect_back_or root_path
#    assert_redirected_to user_path(@user)
#    assert_nil session[:forwarding_url]
#  end
end
