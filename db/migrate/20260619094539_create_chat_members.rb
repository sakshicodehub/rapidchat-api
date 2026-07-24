class CreateChatMembers < ActiveRecord::Migration[8.1]
  def change
    create_table :chat_members do |t|
      t.references :chat, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

    #  t.references :last_message,
    #          foreign_key: { to_table: :messages }

      t.datetime :joined_at
      t.datetime :left_at

      t.integer :role, default: 0

      t.timestamps
    end

    add_index :chat_members,
              [ :chat_id, :user_id ],
              unique: true
  end
end
