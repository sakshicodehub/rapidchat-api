# app/channels/chat_channel.rb
class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_#{params[:chat_id]}"
  end

  def unsubscribed
    # cleanup if needed
  end

  def speak(data) # speak use for no controller involment
    message = Message.create!(
      content: data["content"],
      chat_id: data["chat_id"],
      sender: current_user
    )

    ActionCable.server.broadcast(
      "chat_#{data["chat_id"]}",
      MessageSerializer.new(message).serializable_hash
    )
  end
end
