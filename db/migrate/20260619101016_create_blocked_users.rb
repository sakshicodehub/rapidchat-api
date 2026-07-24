class CreateBlockedUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :blocked_users do |t|
      t.references :user, null: false, foreign_key: true

      t.references :blocked_user, null: false,
                  foreign_key: {
                    to_table: :users
                  }

      t.timestamps
    end
    add_index :blocked_users, [:user_id, :blocked_user_id], unique: true
  end
end
