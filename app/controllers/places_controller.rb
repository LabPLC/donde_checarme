class PlacesController < ApplicationController
  def index
    if params.has_key? :busca
      @centros = Place.where("nombre LIKE ?", params[:busca])
    else
      @centros = Place.all
    end 
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
    if params.has_key? :busca
      @centros.Place.near([@lat, @lon], 3).where("nombre LIKE ?", params[:busca])
    else
      @centros = Place.near([@lat, @lon], 3)
    end
  end
end
