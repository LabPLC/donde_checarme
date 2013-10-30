require 'nokogiri'
def f
  File.open("ReddeHospitalesGDF.kml")
end
def kml
  this = Nokogiri::XML(f)
  this.remove_namespaces!
end

cdata_regex = /^Director:(?<director>.*)Dirección:(?<direccion>.*)Teléfono:(?<telefono>.*)$/x

kml.remove_namespaces!
placemarks = kml.xpath("//Document/Placemark")

placemarks.xpath("//name").each do |p|
  puts p.text
end

placemarks.xpath("//Point/coordinates").each do |p|
  puts p.text
end
#puts placemarks.xpath("//description").text

desc = placemarks.xpath("//description")

desc.each do |d|
  cdata = Nokogiri::HTML(d.text)
  cdata.remove_namespaces!
  texto = cdata.xpath("//div").text

  
  
end