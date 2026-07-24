class ChatMember < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  belongs_to :last_read_message,
             class_name: "Message",
             optional: true

  enum :role, {
        member: 0,
        admin: 1 }
end
