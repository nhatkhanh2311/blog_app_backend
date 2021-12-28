class CreateRelationships < ActiveRecord::Migration[6.1]
  def change
    create_table :relationships do |t|
      t.timestamps
      t.references :follower, foreign_key: { to_table: "users" }
      t.references :followed, foreign_key: { to_table: "users" }
    end

    add_index :relationships, %i[follower_id followed_id]
  end
end
