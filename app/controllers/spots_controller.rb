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
      marker.infowindow gmaps4rails_infowindow
      marker.picture({
        url: "https://maxcdn.icons8.com/Color/PNG/24/Maps/map_pin-24.png",
        width:  25,
        height: 25
      })
    end


  end

  def gmaps4rails_infowindow
    "<p>This is a test</p>"
  end

end
