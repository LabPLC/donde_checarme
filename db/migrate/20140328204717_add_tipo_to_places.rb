class AddTipoToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :categoria, :string
  end
end
