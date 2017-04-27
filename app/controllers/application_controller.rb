class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  after_filter :prepare_unobtrusive_flash
  # before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    spots_path
  end

  def default_url_options
    { host: ENV["HOST"] || "localhost:3000" }
  end

  def get_markers(spots, park_it)
    @hash = Gmaps4rails.build_markers(spots) do |spot, marker|
      marker.lat spot.latitude
      marker.lng spot.longitude
      marker.infowindow gmaps4rails_infowindow(spot, park_it)
      marker.picture({
        url: choose_icon(spot, spot.park_its.last),
        width:  24,
        height: 37
      })
    end
  end


  def gmaps4rails_infowindow(spot, park_it)
    render_to_string(:partial => "/shared/infobox", :locals => {spot: spot, park_it: park_it})
  end

  def choose_icon(spot, park_it)
    current_park_it = current_user.parkits.where(spot_id: spot.id).last
    extra_time_remaining = !park_it.blank? && !park_it.paid_until.nil? && park_it.paid_until > Time.now
    if spot.status == "avail" && extra_time_remaining
      return view_context.asset_path('money.svg')
    elsif spot.status == "taken" && current_park_it
      return view_context.asset_path('personal.svg') # was image path before
    elsif spot.status == "taken"
      return view_context.asset_path('caution.svg') # was image path before
    elsif spot.status == "avail"
      return view_context.asset_path('parking.svg')
    end
  end

  # def configure_permitted_parameters
  #   # For additional fields in app/views/devise/registrations/new.html.erb
  #   # For additional in app/views/devise/registrations/edit.html.erb
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:latitude, :longitude])
  # end
end
