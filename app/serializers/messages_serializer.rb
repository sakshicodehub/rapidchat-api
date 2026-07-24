class MessagesSerializer
  def initialize(messages)
    @messages = messages
  end

  def serialize
    @messages.map { |message| MessageSerializer(message).serialize }
  end
end
