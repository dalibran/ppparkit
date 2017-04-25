class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  # before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    spots_path
  end


  def get_markers(spots, park_it)
    @hash = Gmaps4rails.build_markers(spots) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
      marker.infowindow gmaps4rails_infowindow(spot, park_it)
      marker.picture({
        url: choose_icon(spot),
        width:  24,
        height: 37
      })
    end
  end


  def gmaps4rails_infowindow(spot, park_it)
    render_to_string(:partial => "/shared/infobox", :locals => {spot: spot, park_it: park_it})
  end

  def choose_icon(spot)
    if spot.status == "taken"
      return view_context.asset_path('caution.svg') # was image path before
    elsif spot.status == "avail"
      return view_context.asset_path('parking.svg')
    elsif spot.status == "avail"
      return view_context.asset_path('money.svg')
    end
  end

  # def configure_permitted_parameters
  #   # For additional fields in app/views/devise/registrations/new.html.erb
  #   # For additional in app/views/devise/registrations/edit.html.erb
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:latitude, :longitude])
  # end
end
