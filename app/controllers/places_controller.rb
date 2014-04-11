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
        to_json @centros
      end
    end
  end

  def mapa
  end

  def lista
  end

  def show
    @place = Place.find(params[:id])
    respond_to do |format|
      format.html
      format.json do
        to_json @place
      end
    end
  end

  def search
    #@places = Place.find_by_tipo(params[:tipo])
    @places = Place.seach(params[:tipo])
    respond_to do |format|
      format.html
      format.json do
        to_json @places
      end
    end
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
    @centros.each do |place|
      place.distance = place.distance_to([@lat, @lon], :km)
    end
    respond_to do |format|
      format.html
      format.json do
        to_json @centros
      end
    end
  end

  private

    def to_json(lugares)
      geojson = {
          type: "FeatureCollection",
          features: lugares.map(&:to_geojson)
        }
        render json: geojson
    end
end
