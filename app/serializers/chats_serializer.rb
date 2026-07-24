class ChatsSerializer
  def initialize(chats, current_user)
    @chats = chats
    @current_user = current_user
  end

  def serialize
    @chats.map { |chat| ChatSerializer.new(chat, @current_user).serialize }
  end
end
