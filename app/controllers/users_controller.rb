class UsersController < ApplicationController

	def update
		@user = current_user

		location = params.require(:user).permit(:longitude, :latitude)

		@user.assign_attributes(location)
    	@user.save!

		@park_it = ParkIt.new
		@spots = Spot.near(current_user.position, 0.2)

		if @spots.size < 50
		flash[:notice] = "Not much parking nearby, zoom out to see more."
	      @spots = Spot.near(current_user.position, 0.40)
	    elsif @spots.size > 200
	      @spots = Spot.near(current_user.position, 0.15)
	    end

	    if @spots.size < 2
			flash[:notice] = "Are you sure you are in Montreal?"
		end
		get_markers(@spots, @park_it)

		respond_to do |format|
	      format.js
	    end
	end

end

