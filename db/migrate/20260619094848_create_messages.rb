class CreateMessages < ActiveRecord::Migration[8.1]
  def change
    create_table :messages do |t|
      t.references :chat, null: false, foreign_key: true

      t.references :sender,
                  null: false,
                  foreign_key: { to_table: :users }

      t.integer :message_type,
                null: false,
                default: 0

      t.text :content

      t.integer :reply_to_id

      t.string :attachment_url

      t.datetime :sent_at
      t.datetime :edited_at
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
