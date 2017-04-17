class RulesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @rules = Rule.where.not(latitude: nil, longitude: nil)

    # @hash = Gmaps4rails.build_markers(@rules) do |rule, marker|
    #   marker.lat rule.latitude
    #   marker.lng rule.longitude
      # marker.infowindow render_to_string(partial: "/flats/map_box", locals: { flat: flat })
    # end
  end
end
