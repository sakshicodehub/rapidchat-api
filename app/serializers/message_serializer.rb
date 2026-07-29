class MessageSerializer
  def initialize(message)
    @message = message
  end

  def serialize
    user = @message.sender
    name = user.name || user.phone
    {
      id: @message.id,
      content: @message.content,
      created_at: @message.created_at,
      message_type: @message.message_type,
      reply_to_id: Message.find_by_id(@message.reply_to_id),
      sender_id: @message.sender_id,
      sender_name: name,
      sent_at: @message.sent_at,
      updated_at: @message.updated_at
    }
  end
end
