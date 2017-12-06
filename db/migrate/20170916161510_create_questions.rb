class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :question, null: false#, default: ""
      t.string :correct_ans, null: false#, default: ""
      t.references :subgenre, foreign_key: true
      t.timestamps
    end
  end
end
