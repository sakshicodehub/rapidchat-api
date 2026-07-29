class MessagesSerializer
  def initialize(messages)
    @messages = messages
  end

  def serialize
    @messages.map { |message| MessageSerializer.new(message).serialize }
  end
end
