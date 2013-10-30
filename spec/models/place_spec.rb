require 'spec_helper'

describe Place do
  before { @place = Place.new(nombre: "Lugar de ejemplo", 
                                        latitude:"99.09999", 
                                        longitude:"-90.888888", 
                                        direccion: "blablaba de ejemplo", 
                                        telefono: "555-5555",
                                        encargado: "encargado del centro") }

  subject { @place }

  it { should respond_to( :nombre ) }
  it { should respond_to( :latitude ) }
  it { should respond_to( :longitude ) }
  it { should respond_to( :direccion) }
  it { should respond_to( :encargado)}
  it { should respond_to( :telefono )}

  it { should be_valid}

  describe "cuando el nombre no esta disponible" do
    before { @place.nombre = " "}
    it { should_not be_valid}
  end

  describe "cuando la latitud no esta disponible" do
    before { @place.latitude = nil}
    it { should_not be_valid }
  end

  describe "cuando la longitud no esta disponible" do
    before { @place.longitude = nil}
    it { should_not be_valid}
  end

  describe "cuando el nombre ya existe" do
    before do
      lugar_con_mismo_nombre = @place.dup
      lugar_con_mismo_nombre.save
    end
    it { should_not be_valid}
  end

  describe "cuando el nombre ya existe" do
    before do
      lugar_con_mismo_nombre = @place.dup
      lugar_con_mismo_nombre.nombre = @place.nombre.upcase
      lugar_con_mismo_nombre.save
    end
    it { should_not be_valid}
  end

end
