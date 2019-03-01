# frozen_string_literal: true

require "test_helper"

class Mutations::SignInUserTest < ActiveSupport::TestCase
  def perform(args = {})
    context = { session: { token: "test" } }
    Mutations::SignInUser.new(object: nil, context: context).resolve(args)
  end

  def create_user
    User.create(name: "test", email: "test", password: "test")
  end

  test "success" do
    user = create_user
    result = perform(email: { email: user.email, password: user.password })
    assert result[:token].present?
    assert_equal result[:user], user
  end

  test "failure because no credentials" do
    assert_nil perform
  end

  test "failure because wrong email" do
    create_user
    assert_nil perform(email: { email: "wrong" })
  end

  test "failure because wrong password" do
    user = create_user
    assert_nil perform(email: { email: user.email, password: "wrong" })
  end
end
