class AddDefaultToPlaces < ActiveRecord::Migration
  def change
    change_column(:places, :telefono, :string, default: 0)
  end
end
