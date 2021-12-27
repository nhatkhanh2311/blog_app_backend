class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :content, null: false
      t.timestamps

      t.references :user, foreign_key: true
      t.references :entry, foreign_key: true
    end
  end
end
