class Review < ApplicationRecord
  belongs_to :user
  belongs_to :street_sect
end
