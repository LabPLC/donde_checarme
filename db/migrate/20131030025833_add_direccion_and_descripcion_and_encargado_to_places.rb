class AddDireccionAndDescripcionAndEncargadoToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :direccion, :string
    add_column :places, :encargado, :string
    add_column :places, :telefono, :string, default: "-"
  end
end
