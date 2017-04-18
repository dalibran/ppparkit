class SpotsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @spots = Spot.all



    #gathers lat/lng from db and builds markers for GMaps
    @hash = Gmaps4rails.build_markers(@bikes) do |bike, marker|
      marker.lat bike.latitude
      marker.lng bike.longitude
      # marker.infowindow render_to_string(partial: "/bikes/map_box", locals: { bike: bike })
      # need to build map box partial for the above code to work
    end
  end
end
