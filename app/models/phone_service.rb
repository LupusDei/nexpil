class PhoneService
  def self.send_message(to_number, message)
    new.send_message(to_number, message)
  end

  def send_message(to_number, message)
    auth_token = Rails.application.secrets.twilio_auth_token
    account_sid = Rails.application.secrets.twilio_account_sid
    saved_number = Rails.application.secrets.twilio_phone_number
    to_number = "+1" + to_number

    # begin
      client = Twilio::REST::Client.new account_sid, auth_token

      options = {to: to_number, body: message, from: saved_number}
      sms = client.account.messages.create(options)
    # rescue => e
    #   #notify someone important that the message failed to go through
    # end
  end

end
