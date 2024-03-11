require 'httparty'

class SendpulseService
  include HTTParty
  base_uri 'https://api.sendpulse.com'

  def initialize(_api_user, api_key)
    @options = {
      headers: {
        'Content-Type': 'application/json',
        'Authorization': "Bearer #{api_key}"
      }
    }
  end

  def send_sms(phone_number, message)
    response = self.class.post('/sms/v1/send', @options.merge(body: {
      'phone' => phone_number,
      'text' => message
    }.to_json))

    if response.success?
      puts 'SMS sent successfully!'
    else
      puts "Failed to send SMS: #{response.body}"
    end
  end
end
