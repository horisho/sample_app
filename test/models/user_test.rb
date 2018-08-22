require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: "Example User", email: "user@example.com",
                     password: "foobar")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = " "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = " "
    assert_not @user.valid?
  end

  test "name should be not so long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email shoule be not so long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept calid addresses" do
    invalid_addresses = %w[user@example..com USERfoo.COM 
      A_US-ER@foo.bar.org. first.last@foo,jp alice+bob@baz,cn]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email adresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "" do
    mixed_case_email = "Alpha1Beta2@guMMa.cOm"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "password should be present(nonblank)" do
    @user.password = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = "abc"
    assert_not @user.valid?
  end
end
