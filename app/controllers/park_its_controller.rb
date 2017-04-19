class ParkItsController < ApplicationController
	before_action :set_spot,only: :create

	def create
	@park_it = ParkIt.new(park_it_params) #passed kind and time
    @park_it.user = current_user #assign user
    @park_it.spot = @spot #assign spot
    @park_it.save! #save so we can do points calculation
    @park_it.update!(points: calc_points(@park_it.kind, @park_it.time))
    current_user.points += @park_it.points #update current user with points
    current_user.save! 
    @spot.update!(status: find_avail(@park_it.kind)) #change spot status as function of parkiit kind

  	if @park_it.save && current_user.save && @spot.update
      redirect_to spots_path, notice: "+ #{@park_it.points} for a #{@park_it.kind} ParkIt!"
    else
      render :new
      #may need to change this
    end
	end

	private

	def park_it_params
    params.require(:park_it).permit(:kind, :paid_until)
  end

  def set_spot
    @spot = Spot.find(params[:spot_id])
  end

	def calc_points(kind, time)
		if kind == "park" || kind == "see"
			return 100
		elsif (time - Time.now)/60 > 120 # if expiration time is more than 120 minutes (2 hours) from now
			return 800
		elsif (time - Time.now)/60 < 30 # if expiration time is less than 30 min
			return 200
		else # time left is somewhere between 30 minutes and 3 hours
			return 400
		end
	end

	def find_avail(kind)
		if kind == "park"
			return "taken"
		else
			return "avail"
		end
	end
end
