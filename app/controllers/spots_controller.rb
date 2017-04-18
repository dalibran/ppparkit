class SpotsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @spots = Spot.all
  end
end
