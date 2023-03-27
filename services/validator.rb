# frozen_string_literal: true

require_relative 'slack_client'

class Validator
  class << self
    def length?(params: Hash, length: Integer)
      if params['text'].split.length != length
        SlackClient.send_message(
          channel: params[:channel_id],
          message: 'Incorrect count of arguments.'
        )
        return false
      end

      true
    end
  end
end
