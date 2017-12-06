class CreateUserQuizzes < ActiveRecord::Migration[5.1]
  def change
    create_table :user_quizzes do |t|
      t.integer :user_id
      t.text :user_ans

      t.timestamps
    end
  end
end
