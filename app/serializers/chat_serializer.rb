class ChatSerializer
  def initialize(chat, current_user)
    @chat = chat
    @current_user = current_user
  end

  def serialize
    members = @chat.chat_members
    name = members.where.not(user_id: @current_user.id).first.user.phone
    {
      id: @chat.id,
      name: name,
      chat_id: @chat&.id,
      chat_type: @chat.chat_type,
      members: members,
      messages: @chat.messages
    }
  end

  private

  attr_reader :chat

  def direct_chat
    return nil unless chat.chat_user

    Chat
      .joins(:chat_members)
      .where(chat_type: :direct_chat)
      .where(chat_members: { user_id: [ chat.user.id, chat.chat_user.id ] })
      .group(:id)
      .having("COUNT(DISTINCT chat_members.user_id) = 2")
      .first
  end
end
