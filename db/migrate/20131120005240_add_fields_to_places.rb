class AddFieldsToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :tipo, :string
    add_column :places, :subtipo, :string
    add_column :places, :delegacion, :string
    add_column :places, :horario, :string
  end
end
