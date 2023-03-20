# frozen_string_literal: true

require 'faraday'

class SlackClient
  class << self
    def send_message(message: String, channel: String)
      send_request(
        url: 'https://slack.com/api/chat.postMessage',
        params: {
          channel:,
          text: message
        },
        headers: {
          'Content-type' => 'application/x-www-form-urlencoded',
          'Authorization' => "Bearer #{ENV.fetch('SLACK_API_TOKEN', nil)}"
        }
      )
    end

    private

    def send_request(url: String, params: Hash, headers: Hash)
      conn = Faraday.new(url, params,
                         headers)

      response = conn.post
      JSON.parse(response.body)
    end
  end
end
