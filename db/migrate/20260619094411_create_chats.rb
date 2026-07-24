class CreateChats < ActiveRecord::Migration[8.1]
  def change
    create_table :chats do |t|
      t.integer :chat_type, null: false, default: 0
      t.references :created_by,
                  null: false,
                  foreign_key: { to_table: :users }

      t.string :name
      t.string :avatar_url

      # t.references :last_message, foreign_key: { to_table: :messages }
      t.text :description

      t.timestamps
    end
  end
end
