class Chat < ApplicationRecord
  belongs_to :creator,
             class_name: "User",
             foreign_key: :created_by_id

  has_many :chat_members,
           dependent: :destroy

  has_many :users,
           through: :chat_members

  has_many :messages,
           dependent: :destroy

  enum :chat_type, {
    direct_chat: 0,
    group_chat: 1
  }

  scope :direct_chats, -> { where(chat_type: :direct_chat) }

  # validates :messages, presence: true
  validate :direct_chat_member_limit

   private

  def direct_chat_member_limit
    return unless direct_chat?

    if chat_members.size > 2
      errors.add(
        :base,
        "Direct chat can only have 2 members"
      )
    end
  end
end
