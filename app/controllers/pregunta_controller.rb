class PreguntaController < ApplicationController

  def preguntar
    pregunta = params[:pregunta]
    respond_to do |format|
      format.json { render json: {response: "wololo", forma: {valor: pregunta}}}
    end
  end

end
