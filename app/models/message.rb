class Message < ApplicationRecord
  belongs_to :chat

  belongs_to :sender,
             class_name: "User",
             foreign_key: :sender_id

  has_many :message_receipts,
           dependent: :destroy

  # enum message_type: {
  #             text: 0,
  #             image: 1,
  #             video: 2,
  #             audio: 3,
  #             file: 4,
  #             location: 5
  #           }
end
