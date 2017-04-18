class ParkIt < ApplicationRecord
  belongs_to :spot
  belongs_to :user

  validates :kind, inclusion: { in: ["Take a Spot", "Leave a Spot", "Leave a Spot with Time Remaining"] }
end
