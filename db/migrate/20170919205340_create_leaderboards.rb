class CreateLeaderboards < ActiveRecord::Migration[5.1]
  def change
    create_table :leaderboards do |t|
      t.integer :genre
      t.integer :user
      t.integer :subgenre
      t.integer :question
      t.integer :total_qns
      t.integer :attempted
      t.integer :score

      t.timestamps
    end
  end
end
