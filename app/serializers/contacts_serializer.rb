class ContactsSerializer
  def initialize(contacts, current_user)
    @contacts = contacts
    @current_user = current_user
  end

  def serialize
    @contacts.map { |contact| ContactSerializer.new(contact, @current_user).serialize }
  end
end
