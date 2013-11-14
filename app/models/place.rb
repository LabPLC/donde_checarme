class Place < ActiveRecord::Base

reverse_geocoded_by :latitude, :longitude

  validates :nombre, presence: true,
                  uniqueness: { case_sensitive: false}
  validates :latitude, presence: true
  validates :longitude, presence: true
end
