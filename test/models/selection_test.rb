require "test_helper"

class SelectionTest < ActiveSupport::TestCase
  context "associations" do
    should belong_to(:round)
    should belong_to(:user)
  end

  context "validations" do
    should validate_uniqueness_of(:user_id).scoped_to(:round_id)
  end
end
