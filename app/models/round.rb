class Round < ApplicationRecord
  has_many :selections, -> { order(:id) }
end
