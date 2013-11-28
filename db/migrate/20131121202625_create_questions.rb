class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :palabra

      t.timestamps
    end
  end
end
