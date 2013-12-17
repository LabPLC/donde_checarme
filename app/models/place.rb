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

class Place < ActiveRecord::Base

  has_many :categorizations
  has_many :categories, :through => :categorizations

  reverse_geocoded_by :latitude, :longitude

  validates :nombre, presence: true,
                  uniqueness: { case_sensitive: false }
  validates :latitude, presence: true
  validates :longitude, presence: true


  def categories?(category)
    categorizations.find_by(category_id: category.id)
  end

  def add_category!(category)
    categorizations.create(category_id: category.id)
  end

  def self.search(busqueda, latitude = 0, longitude = 0, dist = 3)
    places = nil
    if latitude == 0 || longitude == 0
      places =  self.where("nombre LIKE :busqueda 
                  OR tipo LIKE :busqueda", :busqueda => busqueda)
    else
      places = self.near([latitude, longitude], dist).where("nombre LIKE :busqueda 
                  OR tipo LIKE :busqueda", :busqueda => busqueda)
    end
    
  end
end
