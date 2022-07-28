class User < ApplicationRecord
  validates :name, :email, presence: true
  validates :email, uniqueness: { case_sensitive: false }
  validates :archived, exclusion: [nil]

  scope :unarchived, -> { where(archived: false) }
end
