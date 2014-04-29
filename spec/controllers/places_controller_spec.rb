require 'spec_helper'

describe PlacesController do
  describe "GET mapa" do
    it "shows the map" do
      get :mapa
      expect(response).to render_template("mapa")
    end

    it "creates resources" do
      place = Place.all
      get :index
      expect(assigns(:centros)).to eq(place)
    end

    it "renders JSON successfuly" do
      get :index, :format => :json
      response.should  be_success
    end

    it "renders successfuly" do
      get :index
      response.should be_success
    end
  end

  describe "GET lugares" do
    it "renders successfuly" do
      get :lugares, :format => :json
      response.should be_success
    end

    it "creates resources" do
      get :lugares, :format => :json
      expect(assigns(:centros)).to be_a(ActiveRecord::Relation)
    end
  end

  describe "GET search" do
    it "renders failure without params" do
      get :search, :format => :json
      response.should_not be_success
    end



  end
end
