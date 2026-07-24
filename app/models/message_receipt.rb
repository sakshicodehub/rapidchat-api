class MessageReceipt < ApplicationRecord
  belongs_to :user
  belongs_to :chat

  enum status: {
    sent: 0,
    delivered: 1,
    read: 2
  }
end
