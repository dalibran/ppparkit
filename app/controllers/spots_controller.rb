class SpotsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @park_it = ParkIt.new

    @spots = Spot.near(current_user.position, 0.2)
    # @spots = []
    # 5.times do
    #   @spots << Spot.find(rand(1..4))
    # end
    # gathers lat/lng from db and builds markers for GMaps

    # pass this to the new parkit event
    get_markers(@spots)
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

  def get_markers(spots)
    @hash = Gmaps4rails.build_markers(spots) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
      marker.infowindow gmaps4rails_infowindow(spot, @park_it)
      marker.picture({
        url: choose_icon(spot),
        width:  25,
        height: 25
      })
    end
  end


  def gmaps4rails_infowindow(spot, park_it)
    render_to_string(:partial => "/shared/infobox", :locals => {spot: spot, park_it: park_it})
  end

  def choose_icon(spot)
    if spot.status == "taken"
      return view_context.asset_path('cancel24.png') # was image path before
    elsif spot.status == "avail"
      return view_context.asset_path('check24.png')
    elsif spot.status == "paid_for"
      return view_context.asset_path('check24.png')
    end
  end

end
