require 'spec_helper'

describe "PaginasEstaticas" do

  let(:titulo_base) { "Checate Aqui" }

  describe "Pagina de inicio" do
    
    it "debe tener el Contenido 'Donde'" do
      visit '/static_pages/home'
      expect(page).to have_content('Donde')
    end

    it "debe tener el titulo 'Checate aqui'" do
      visit '/static_pages/home'
      expect(page).to have_title("#{titulo_base} | Inicio")
    end
  end

  describe "Pagina de Ayuda" do
    it "debe tener el contenido 'Ayuda'" do
      visit '/static_pages/ayuda'
      expect(page).to have_content('Ayuda')
    end
    
  end
end
