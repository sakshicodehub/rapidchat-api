class Api::V1::ChatsController < ApplicationController
  def index
    puts current_user.phone
    @chats = current_user.chats
                        .includes(:chat_members, messages: :sender)
    render json: ChatsSerializer.new(@chats, current_user).serialize
  end

  def show
    @chat = Chat.find(params["id"])
    render json: ChatSerializer.new(@chat, current_user).serialize
  end

  def create
    chat = case chat_params[:chat_type]
    when "direct_chat"
        direct_chat
    when "group_chat"
        group_chat
    else
      render json: { error: "Invalid chat type" }, status: :unprocessable_entity
      return
    end

    render json: chat
  end

  def add_member
    chat = Chat.find(params[:id])

    ChatMember.create!(
      chat: chat,
      user_id: params[:user_id],
      joined_at: Time.current
    )

    render json: {
      success: true
    }
  end

  private

  def direct_chat
    byebug
    @receiver = User.find_by(phone: chat_params["phone"])
    chat =Chat.create!(chat_type: :direct_chat, created_by_id: current_user.id)

    ChatMember.create!(
      chat_id: chat.id,
      user_id: current_user.id,
      joined_at: Time.current,
    )

    ChatMember.create!(
      chat: chat,
      user: @receiver,
      joined_at: Time.current
    )
    chat
  end

  def group_chat
    chat = Chat.create!(
      chat_type: :group_chat,
      name: params[:name],
      created_by_id: current_user.id
    )

    ChatMember.create!(
      chat: chat,
      user: current_user,
      admin: true,
      joined_at: Time.current
    )

    params[:member_ids].each do |user_id|
      ChatMember.create!(
        chat: chat,
        user_id: user_id,
        joined_at: Time.current
      )
    chat
    end
  end

  def chat_params
    params.require(:chat).permit(:phone, :chat_type, :created_by)
  end
end
