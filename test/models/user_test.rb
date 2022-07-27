require "test_helper"

class UserTest < ActiveSupport::TestCase
  context "validations" do
    should validate_presence_of(:name)
    should validate_presence_of(:email)
    should validate_uniqueness_of(:email).case_insensitive
    should validate_exclusion_of(:archived).in_array([nil])
  end
end
