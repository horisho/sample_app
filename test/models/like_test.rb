require 'test_helper'

class LikeTest < ActiveSupport::TestCase
  
  def setup
    @user = users(:michael)
    @micropost = microposts(:orange)
    @like = likes(:one)
    @other_like = likes(:two)
  end

  test "like should be valid" do
    assert @like.valid?
  end

  test "like should not be valid when user_id is nil" do
    @like.user_id = nil
    assert_not @like.valid?
  end
end
