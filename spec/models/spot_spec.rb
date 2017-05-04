require 'rails_helper'

RSpec.describe Spot, type: :model do
	it 'is Montreal' do
		spot = Spot.create!
		expect(spot.address).to eq 'Montreal, QC, Canada'
	end
end
