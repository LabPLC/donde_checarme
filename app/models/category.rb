# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  tipo       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Category < ActiveRecord::Base
  has_many :categorizations
  has_many :places, :through => :categorizations

  def self.search
  end
end
