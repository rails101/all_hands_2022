require "test_helper"

class RoundTest < ActiveSupport::TestCase
  context "associations" do
    should have_many(:selections).order(:id)
  end
end
