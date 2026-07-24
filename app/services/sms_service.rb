class SmsService
  def self.send_sms(phone, message)
    # Here you would integrate with an SMS service to send the message to the user's phone number
    # For example, using Twilio:
    # client = Twilio::REST::Client.new(account_sid, auth_token)
    # client.messages.create(
    #   from: twilio_phone_number,
    #   to: phone,
    #   body: message
    # )
    puts "Sending SMS to #{phone}: #{message}"
  end
end
