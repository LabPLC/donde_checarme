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
#  categoria  :string(255)
#

class Place < ActiveRecord::Base

  include Filterable

  scope :contiene, ->(termino) { where("upper(nombre) like ?", "%#{termino.upcase}%")}
  scope :tipos, ->(tipos) { where tipo: tipos}

  has_many :categorizations
  has_many :categories, :through => :categorizations

  reverse_geocoded_by :latitude, :longitude

  validates :nombre, presence: true,
                  uniqueness: { case_sensitive: false }
  validates :latitude, presence: true
  validates :longitude, presence: true

  attr_reader :distance

  def distance=(val)
    @distance = val.round(2)
  end


  def categories?(category)
    categorizations.find_by(category_id: category.id)
  end

  def add_category!(category)
    categorizations.create(category_id: category.id)
  end

  def to_geojson
    #telefono = telefono.scan(/(\d{7,10})/)[1] unless telefono.nil?
    if !telefono.nil?
      tele = telefono.gsub(/-/, "").gsub(/\s+/, "").scan(/(\d{7,10})/)[0]

      if tele[0].length < 10
        tele[0].insert(0, "55")
      end
      telefono = tele
    end
    {
      type: "Feature",
      geometry: {
        type: "Point",
        coordinates: [longitude, latitude]
      },
      properties: {
        id: id,
        name: nombre,
        address: direccion,
        encargado: encargado,
        tipo: tipo,
        subtipo: subtipo,
        delegacion: delegacion,
        horario: horario,
        telefono: telefono,
        icon: {:'iconUrl' => '/assets/images/pin_ubicacion_hospital.png',
                  :'iconSize'=> [30,50],
                  :'iconAnchor' => [15,50],
                  :'popupAnchor' => [0, -50]},
        distance_to_center: distance
      }
    }
  end

  def self.get_hospitals
    Place.where(tipo: "Hospital")
  end

  def self.search(busqueda, latitude = 0, longitude = 0, dist = 3)
    if latitude == 0 || longitude == 0
      places =  self.where("nombre LIKE :busqueda
                  OR tipo LIKE :busqueda", :busqueda => "%" + busqueda + "%")
    else
      places = self.near([latitude, longitude], dist).where("nombre LIKE :busqueda
                  OR tipo LIKE :busqueda", :busqueda => "%" + busqueda + "%")
    end
    places = self.near(busqueda + " Ciudad de Mexico", 2, order: "distance")

  end
end
