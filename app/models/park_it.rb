class ParkIt < ApplicationRecord
  belongs_to :spot
  belongs_to :user

  validates :kind, inclusion: { in: ["park", "leave", "see", "update"] }
end
