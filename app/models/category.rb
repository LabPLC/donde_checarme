class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :places, :through => :categorizations
end
