class CreatePregunta < ActiveRecord::Migration
  def change
    create_table :pregunta do |t|
      t.string :texto

      t.timestamps
    end
  end
end
