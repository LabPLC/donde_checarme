# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  palabra    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Question < ActiveRecord::Base
end
