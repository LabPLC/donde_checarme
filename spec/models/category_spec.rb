# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  tipo       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe Category do
  before { @category = Place.new(:tipo => "Test")}
  subject { @category }

  it {should respond_to(:tipo)}
  it {should respond_to(:categorizations)}

  context "metodos de clase" do
    subject { @categories = Category }
    describe "debe tener un metodo de buscar" do
      it {should respond_to(:search)}

    end
  end
end
