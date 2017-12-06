class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :encrypted_password, null: false
      t.string :salt
      t.boolean :admin, null: false ,default: false
      t.timestamps :null => true
    end
    end

end
