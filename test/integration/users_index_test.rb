require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
  end

  test "index including pagination and delete links" do
    log_in_as @admin
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    first_page_of_users = User.where(activated: true).paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.where(activated: true).count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as @non_admin
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    assert_select 'a', text: 'delete', count: 0
  end

  test "retrieval a user the standard way" do
    log_in_as @admin
    get users_path
    post retrieval_path, params: { retrieval: { string: "Archer" } }
    assert_match 'Archer', response.body, count: 2
  end
end
