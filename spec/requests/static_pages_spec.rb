require 'spec_helper'

describe "PaginasEstaticas" do

  let(:titulo_base) { "Checate Aqui" }


  describe "Pagina de inicio" do

    before { visit root_path }
    
    it "debe tener el Contenido 'Donde'" do
      expect(page).to have_content('donde')
    end

    it "debe tener el titulo 'Checate aqui'" do
      expect(page).to have_title("#{titulo_base} | Inicio")
    end
  end

  describe "Pagina de Ayuda" do
    before { visit ayuda_path }

    it "debe tener el contenido 'Ayuda'" do
      expect(page).to have_content('Ayuda')
    end
    
  end
end
