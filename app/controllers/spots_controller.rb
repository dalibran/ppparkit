class SpotsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @park_it = ParkIt.new
    @spots = Spot.near(current_user.position, 0.2)
    # gathers lat/lng from db and builds markers for GMaps
    get_markers(@spots, @park_it)
  end

  def update
    @spot = Spot.find(params[:id])
    current_user.points += params[:spot][:points].to_i #update current user with points
    current_user.save!

    @park_it = ParkIt.new
    #get_markers(Spot.near(current_user.position, 0.2))

    if @spot.status == "taken" #toggle spot status
      @spot.update!(status: "avail")
    else
      @spot.update!(status: "taken")
    end

    respond_to do |format|
      format.js
    end
  end

end
