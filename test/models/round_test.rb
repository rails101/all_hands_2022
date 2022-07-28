require "test_helper"

class RoundTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:selections).order(:id)
    should have_many(:users).through(:selections)
  end

  context "#available_users" do
    should "return all available users when none have been selected" do
      available_users = [
        users(:sarah),
        users(:chantel),
        users(:adrian),
        users(:daniel),
      ]

      round = rounds(:empty)
      assert_equal available_users.sort, round.available_users.sort
    end

    should "return no users when all available have been selected" do
      round = rounds(:full)
      assert_equal [], round.available_users
    end
  end
end
