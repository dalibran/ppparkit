class UsersController < ApplicationController

	def update
		@user = current_user
		location = params.require(:user).permit(:longitude, :latitude)
		@user.update!(location)
		@park_it = ParkIt.new
		@spots = Spot.near(current_user.position, 0.2)
		get_markers(@spots)
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

