class Api::V1::MessagesController < ApplicationController
  def index
    @messages = Message.where(chat_id: params[:chat_id]).order(sent_at: :asc)
    render json: MessagesSerializer.new(@messages)
  end
  def create
    @chat = Chat.find(message_params["chat_id"])
    @message = Message.new(message_params)

    @message = @chat.messages.create!(message_params.merge(sender: current_user))

    if @message.persisted?

      ActionCable.server.broadcast(
        "chat_#{@message.chat_id}",
        {
          message: MessageSerializer.new(@message)
        }
      )

      render json: { success: true, data:  MessageSerializer.new(@message) }, status: :ok
    else
      render json: { success: false, errors: @message.errors }, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :chat_id, :message_type, :sent_at)
  end
end
