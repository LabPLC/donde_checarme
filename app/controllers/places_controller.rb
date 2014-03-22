class PlacesController < ApplicationController
  def index
    if params.has_key? :busca
      @centros = Place.where("nombre LIKE ?", params[:busca])
    else
      @centros = Place.all
    end
    respond_to do |format|
      format.html
      format.json do
        geojson = {
          type: "FeatureCollection",
          features: @centros.map(&:to_geojson)
        }
        render json: geojson
      end
    end
  end

  def lista
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
      puts "yaay"
      @centros = Place.near([@lat, @lon], 2).where("nombre LIKE ?", params[:busca])
      if @centros.count == 0
        query_busqueda = params[:busca] + " Ciudad de Mexico"
        puts query_busqueda
        @centros = Place.near(query_busqueda, 2)
      end
    else
      @centros = Place.near([@lat, @lon], 2)
    end
  end
end
