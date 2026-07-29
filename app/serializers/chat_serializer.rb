class ChatSerializer
  def initialize(chat, current_user)
    @chat = chat
    @current_user = current_user
  end

  def serialize
    members = @chat.chat_members

    if @chat.chat_type == "direct_chat"
      user = members.where.not(user_id: @current_user.id).first.user
      name = user.name || user.phone
    else
      name = @chat.name
    end

    {
      id: @chat.id,
      name: name,
      chat_id: @chat&.id,
      chat_type: @chat.chat_type,
      members: members,
      current_user_id: @current_user.id,
      messages: MessagesSerializer.new(@chat.messages).serialize
    }
  end
end
