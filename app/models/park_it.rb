class ParkIt < ApplicationRecord
  belongs_to :spot
  belongs_to :user

  validates :paid_until, presence: true, allow_nil: false
  # validates :kind, inclusion: { in: ["park", "leave", "see", "update"] }
end
