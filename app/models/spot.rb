class Spot < ApplicationRecord
  has_many :park_its
  geocoded_by :address

  def address
    "Montreal, QC, Canada"
  end
 
end
