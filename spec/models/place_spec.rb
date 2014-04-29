# == Schema Information
#
# Table name: places
#
#  id         :integer          not null, primary key
#  nombre     :string(255)
#  latitude   :float
#  longitude  :float
#  created_at :datetime
#  updated_at :datetime
#  direccion  :string(255)
#  encargado  :string(255)
#  telefono   :string(255)
#  tipo       :string(255)
#  subtipo    :string(255)
#  delegacion :string(255)
#  horario    :string(255)
#

require 'spec_helper'

describe Place do
  context "todo sobre los lugares" do
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

    describe "guardar algo" do
      before { @place.save }
      it { should be_valid}
    end

    describe "no debo guardar sin lat ni long" do
      before { @place.latitude = nil }
      it "no debe ser valido sin lat" do
        expect(@place).to_not be_valid
      end

    end

    describe "cuando la latitud no esta disponible" do
      before { @place.latitude = nil}
      it { should_not be_valid }
    end

    describe "cuando la longitud no esta disponible" do
      before { @place.longitude = nil}
      it { should_not be_valid}
    end

    describe "regresa un geojson" do
      before { @place.to_geojson }
      it { should be_valid }
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

    describe "busqueda de un lugar" do
      it "no debe ser valido sin parametros" do
        expect{Place.search()}.to raise_error
      end
    end

  end
  context "para los metodos de clase" do

    describe "deben regresar los hospitales" do
      before { @places = Place.get_hospitals }
      subject { @places }
      it{ should_not be_nil }
      it {should be_a ActiveRecord::Relation}
    end
  end
end

