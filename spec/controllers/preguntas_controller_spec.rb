require 'spec_helper'

describe PreguntaController do

  describe "GET preguntas" do
    it "renders JSON successfully if query" do
      json = { :format => 'json', :pregunta => "query" }
      post :preguntar, json
      response.should be_success
    end

    it "fails if there is no query" do
      json = { :format => 'json'}
      post :preguntar, json
      response.should_not be_success
    end

    describe "when there is a match between the question and a place" do
      before do
        pregunta = Pregunta.create(texto: "query")
        place = Place.create(nombre: "Lugar de ejemplo",
                                        latitude:"99.09999",
                                        longitude:"-90.888888",
                                        direccion: "blablaba de ejemplo",
                                        telefono: "555-5555",
                                        encargado: "encargado del centro",
                                        categoria: "query")
      end
      it " renders JSON successfully" do
        json = { :format => 'json', :pregunta => "query" }
        post :preguntar, json
        JSON.parse(response.body)["type"] == "FeatureCollection"
      end
    end


  end

end
