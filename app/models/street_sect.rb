class StreetSect < ApplicationRecord
  has_many :reports
  has_many :reviews
  has_many :rules
end
