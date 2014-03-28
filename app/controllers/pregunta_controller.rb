class PreguntaController < ApplicationController

  def preguntar
    pregunta = params[:pregunta]
      a = Pregunta.new(texto: pregunta)
      puts a

    respond_to do |format|
      format.json { render json: a}
    end
  end

end
