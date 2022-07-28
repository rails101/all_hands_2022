require "test_helper"

class SelectionTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:round)
    should belong_to(:user)
  end

  context "validations" do
    should validate_uniqueness_of(:user_id).scoped_to(:round_id)
  end

  context "after initialize" do
    should "select a random available user" do
      available_users = [
        users(:sarah),
        users(:chantel),
        users(:adrian),
        users(:daniel),
      ]

      unavailable_users = [
        users(:casper),
        users(:stretch),
        users(:fatso),
        users(:stinkie),
      ]

      round = rounds(:empty)
      selection = Selection.new(round: round)
      assert_includes available_users, selection.user
      assert_not_includes unavailable_users, selection.user
    end

    should "not select a user when round is not set" do
      selection = Selection.new
      assert_nil selection.user
    end

    should "not select a user when one has been set" do
      round = rounds(:empty)
      user = users(:daniel)
      selection = Selection.new(round: round, user: user)
      assert_equal user, selection.user
    end

    should "not select a user when all have been selected" do
      round = rounds(:full)
      selection = Selection.new(round: round)
      assert_nil selection.user
    end
  end
end
