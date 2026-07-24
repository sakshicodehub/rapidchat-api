class Api::V1::ChatMembersController < ApplicationController
  def create
    @chat_member = ChatMember.new(chat_member_params)
    if @chat_member.save
      render json: { success: true, data: @chat_member }, status: :ok
    else
      render json: { success: false, errors: @chat_member.errors }, status: :unprocessable_entity
    end
  end

  private

  def chat_member_params
    params.require(:chat_member).permit(:user_id, :chat_id, :joined_at, :left_at, :admin, :last_read_message_id)
  end
end
