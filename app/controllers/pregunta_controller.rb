class PreguntaController < ApplicationController

  rescue_from NoMethodError, with: :failure_message

  def preguntar
    pregunta = params[:pregunta]
    a = Pregunta.create(texto: pregunta)
    if a.is_in_cat?(a.texto)
      lugares = Place.get_hospitals
    else
      lugares = Place.near(a.texto + " Ciudad de Mexico", 2)
    end
    respond_to do |format|
      format.html
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

      def failure_message(error)
      render :json => { :error => error.message}, :status => :not_found
    end

end
