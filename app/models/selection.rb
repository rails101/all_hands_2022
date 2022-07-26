class Selection < ApplicationRecord
  belongs_to :round
  belongs_to :user

  validates :user_id, uniqueness: { scope: :round_id }

  after_initialize do |selection|
    if selection.round.present? && selection.user.blank?
      selection.user = round.available_users.sample
    end
  end
end
