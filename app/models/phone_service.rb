class PhoneService

  def send_message(to_number, message)
    auth_token = SECRET_KEYS["twilio_secret_key"]
    account_sid = SECRET_KEYS["twilio_api_key"]
    saved_number = SECRET_KEYS["twilio_phone_number"]
    to_number = "+1" + to_number

    begin
      client = Twilio::REST::Client.new account_sid, auth_token

      options = {to: to_number, body: message, from: saved_number}
      sms = client.account.messages.create(options)
    rescue => e
      #notify someone important that the message failed to go through
    end
  end

end
