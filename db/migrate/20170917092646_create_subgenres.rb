class CreateSubgenres < ActiveRecord::Migration[5.1]
  def change
    create_table :subgenres do |t|
      t.references :genre,foreign_key: true
      t.string :name
      t.text :description
      t.integer :no_questions

      t.timestamps
    end
  end
end
