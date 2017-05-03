class Spot < ApplicationRecord
  has_many :park_its
  geocoded_by :address

  def address
    'Montreal, QC, Canada'
  end

  def self.near_user(user)
    limit = 30
    spots = Spot.near(user.position, 0.2).limit(limit)
    if spots.size < limit
      spots = Spot.near(user.position, 0.40).limit(limit)
    end
    spots
  end

 
end
