# == Schema Information
#
# Table name: pregunta
#
#  id         :integer          not null, primary key
#  texto      :string(255)
#  created_at :datetime
#  updated_at :datetime
#  type       :string(255)
#

require 'spec_helper'

describe Pregunta do
  before do
    @pregunta = Pregunta.new(texto: "query")
    @cosa = Category.new(tipo: "query")
  end

  subject { @pregunta }

  it { should respond_to(:texto) }
  it {should respond_to(:is_in_cat?)}

  describe "regresa true o false al buscar si existe categoria" do
    before { @cosa.save}
    it "debe regresar true si existe" do
      expect(@pregunta.is_in_cat?("query")).to be_true
    end
    it "debe regresar false si no existe" do
      expect(@pregunta.is_in_cat?("not_query")).to be_false
    end
  end
end
