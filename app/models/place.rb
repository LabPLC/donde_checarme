class Place < ActiveRecord::Base

  validates :nombre, presence: true,
                  uniqueness: { case_sensitive: false}
  validates :latitude, presence: true
  validates :longitude, presence: true
end
