class User < ApplicationRecord
  has_many :messages,
           foreign_key: :sender_id

  has_many :chat_members

  has_many :chats,
           through: :chat_members

  has_many :contacts

  has_many :contact_users,
           through: :contacts,
           source: :contact_user

  def has_direct_chat_with?(user_id)
    chats
      .direct_chats
      .joins(:chat_members)
      .where(chat_members: { user_id: user_id })
      .exists?
  end
end