class Spot < ApplicationRecord
  has_many :parkits
  geocoded_by :address

  def address
    "Montreal, QC, Canada"
  end
 
end
