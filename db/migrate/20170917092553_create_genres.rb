class CreateGenres < ActiveRecord::Migration[5.1]
  def change
    create_table :genres do |t|
      t.string :genre
      t.text :description
      t.integer :no_questions

      t.timestamps
    end
  end
end
