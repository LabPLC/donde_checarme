class PlacesController < ApplicationController
  def index
    @centros = Place.all
  end

  def lugares
    @lat = params[:latitude]
    @lon = params[:longitude]
    @centros = Place.near([@lat, @lon], 3)
  end
end
