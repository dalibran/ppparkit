class SpotsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def index
    @spots = Spot.near(current_user.position, 0.2)
    # @spots = []
    # 5.times do
    #   @spots << Spot.find(rand(1..4))
    # end

    #gathers lat/lng from db and builds markers for GMaps
    @hash = Gmaps4rails.build_markers(@spots) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
      marker.infowindow gmaps4rails_infowindow(spot)
      marker.picture({
        url: choose_icon(spot),
        width:  25,
        height: 25
      })
    end


  end

  def gmaps4rails_infowindow(spot)
    render_to_string(:partial => "/shared/infobox", :locals => {spot: spot}) 
  end

  def choose_icon(spot)
    if spot.status == "taken"
      return view_context.asset_path('cancel24.png') # was image path before
    else
      return view_context.asset_path('check24.png')
    end
  end

end