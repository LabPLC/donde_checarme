# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'csv'
require 'i18n'

csv_fname = 'datos/hospitales.csv'

csv = CSV.read(csv_fname, :headers => true )

csv.each do |row|
  place =Place.create(
    nombre: row['NOMBRE_CENTRO'],
    delegacion: row['NOMBRE_DELEGACION'],
    latitude: row['LONGITUD'],
    longitude: row['LATITUD'],
    telefono: row['TELEFONO'],
    direccion: row['DOMICILIO'],
    horario: row['HORARIO'],
    tipo: I18n.transliterate(row['TIPO']),
    subtipo: row['SUB-TIPO'],
    categoria: row['CATEGORIAS']
    )
end

Category.create(tipo: "condones")
Category.create(tipo: "urgencias")
Category.create(tipo: "rayos x")
Category.create(tipo: "condones")





=begin
require 'nokogiri'
def f
  File.open("datos/ReddeHospitalesGDF.kml")
end
def kml
  this = Nokogiri::XML(f)
  this.remove_namespaces!
end

def extract_desc(desc)
  cdata = Nokogiri::HTML(desc.text)
  cdata.remove_namespaces!
  cdata.xpath("//div").text
end

kml.remove_namespaces!
placemarks = kml.xpath("//Document/Placemark")

cdata_regex = /(Director:*)?(?<director>.*)(Dirección*:)+(?<direccion>.*)(Teléfono:*)+(?<telefono>.*)/x

places = []
i = 1
puts placemarks.count
placemarks.each do |p|
  name = p.xpath("name").text
  coord = p.xpath("Point/coordinates").text
  longitude, latitude = coord.split(',')
  texto = extract_desc(p.xpath("description"))

  partes = texto.match(cdata_regex)
  #puts partes[:director]
   puts partes[:telefono]
  # puts partes[:direccion]
  # puts "#{latitude} --- #{longitude}"
  p = Place.new(nombre: name,
                            latitude: latitude,
                            longitude: longitude,
                            direccion: partes[:direccion],
                            encargado: partes[:director],
                            telefono: partes[:telefono])
  places.push(p)
=end
