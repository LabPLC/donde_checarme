class PlacesController < ApplicationController
  def index
    @centros = Place.all

    respond_to do |format|
      format.html
      format.json { render :json => @centros }
    end
  end
end
