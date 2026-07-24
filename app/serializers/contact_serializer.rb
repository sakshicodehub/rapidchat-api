class ContactSerializer
  def initialize(contact, current_user)
    @contact = contact
    @current_user = current_user
  end

  def serialize
    chat = direct_chat
    {
      id: contact.id,
      nickname: contact.nickname,
      phone: contact.contact_user&.phone,
      is_direct_chat: chat.present?,
      chat_id: chat&.id
    }
  end

  private

  attr_reader :contact

  def direct_chat
    return nil unless contact.contact_user

    Chat
      .joins(:chat_members)
      .where(chat_type: :direct_chat)
      .where(chat_members: { user_id: [ contact.user.id, contact.contact_user.id ] })
      .group(:id)
      .having("COUNT(DISTINCT chat_members.user_id) = 2")
      .first
  end
end
