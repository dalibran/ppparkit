class StreetSectsController < ApplicationController
  def index
    @streets = Street_Sect.all
  end
end
