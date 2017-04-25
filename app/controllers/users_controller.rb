class UsersController < ApplicationController

	def update
		@user = current_user

		location = params.require(:user).permit(:longitude, :latitude)

		@user.assign_attributes(location)
    @user.save!

		@park_it = ParkIt.new
		@spots = Spot.near(current_user.position, 0.2)
		get_markers(@spots, @park_it)

		respond_to do |format|
      format.js
    end
	end

end

