class AddTypeToPregunta < ActiveRecord::Migration
  def change
    add_column :pregunta, :type, :string
  end
end
