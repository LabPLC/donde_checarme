class PreguntaController < ApplicationController

  def preguntar
    pregunta = params[:pregunta]
    a = Pregunta.new(texto: pregunta)
    if a.save!
      puts a
    end
    lugares = Place.search(a.texto)
    puts lugares
    respond_to do |format|
      format.json do
        to_json lugares
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
