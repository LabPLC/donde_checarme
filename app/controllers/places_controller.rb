class PlacesController < ApplicationController
  def index
    @centros = Place.all
  end

  def show
    @place = Place.find(params[:id])
  end

  def search
    @places = Place.find_by_tipo(params[:tipo])
  end

  def lugares
    @lat = params[:latitude]
    @lon = params[:longitude]
    @centros = Place.near([@lat, @lon], 3)
  end
end
