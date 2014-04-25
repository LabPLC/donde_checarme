require 'spec_helper'

describe "PlacePages" do

  let(:titulo_base) { "Checate Aqui" }

  subject { page }

  describe "pagina del mapa" do
    before { visit '/' }

    it { should have_css('div#map') }
    it { should have_title("#{titulo_base}") }
  end
end
