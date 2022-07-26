class Round < ApplicationRecord
  has_many :selections, -> { order(:id) }
  has_many :users, through: :selections

  def available_users
    User.without(users)
  end
end
