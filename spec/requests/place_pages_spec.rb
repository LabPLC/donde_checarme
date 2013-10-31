require 'spec_helper'

describe "PlacePages" do

  let(:titulo_base) { "Checate Aqui" }
  
  subject { page }

  describe "pagina del mapa" do
    before { visit mapa_path }

    it { should have_css('div.mapa') }
    it { should have_title("#{titulo_base} | Mapa") }
  end
end
