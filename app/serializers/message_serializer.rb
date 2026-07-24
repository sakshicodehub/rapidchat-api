class MessageSerializer
  def initialize(message)
    @message = message
  end

  def serializer
    {
      id: @message.id,
      content: @message.content,
      created_at: @message.created_at,
      message_type: @message.message_type,
      reply_to_id: Message.find(@message.reply_to_id),
      sender_id: @message.sender_id,
      sent_at: @message.sent_at,
      updated_at: @message.updated_a
    }
  end
end
