class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :phone, null: false
      t.string :name
      t.string :about
      t.string :avatar_url

      t.datetime :last_seen_at
      t.boolean :online, default: false

      t.timestamps
    end

    add_index :users, :phone, unique: true
  end
end
