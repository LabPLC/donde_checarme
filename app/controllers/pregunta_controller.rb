class PreguntaController < ApplicationController

  def preguntar
    pregunta = params[:pregunta]
    a = Pregunta.save!(texto: pregunta)

    lugares = Place.near(a.texto + "")
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
