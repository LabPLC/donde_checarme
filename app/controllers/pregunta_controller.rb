class PreguntaController < ApplicationController

  def preguntar
    pregunta = params[:pregunta]
    a = Pregunta.new(texto: pregunta)
    if a.save
      puts a
    end
    lugares = Place.search(a.texto)
    puts lugares
    respond_to do |format|
      format.json { render json: a}
    end
  end

end
