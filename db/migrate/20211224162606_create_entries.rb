class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.string :title, null: false
      t.text :body
      t.timestamps

      t.references :user, foreign_key: true
    end
  end
end
