require "test_helper"

class RoundTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:selections).order(:id)
    should have_many(:users).through(:selections)
  end

  context "#available_users" do
    should "return all users when none have been selected" do
      round = rounds(:empty)
      assert_equal users.sort, round.available_users.sort
    end

    should "return no users when all have been selected" do
      round = rounds(:full)
      assert_equal [], round.available_users
    end
  end
end
