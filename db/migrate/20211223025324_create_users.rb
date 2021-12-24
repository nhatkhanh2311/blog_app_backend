class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest, null: false
      t.string :name, null: false
      t.string :email, null: false
      t.date :birthday
      t.string :phone
      t.integer :gender, null: false
      t.timestamps
    end

    add_index :users, :username
    add_index :users, :email
  end
end
