# frozen_string_literal: true

class JwtService
  class << self
    def generate_token(params:)
      params[:external_user_id] = params.delete(:user_id)
      JWT.encode(
        params.slice(:external_user_id, :channel_id),
        ENV.fetch('TCL_SECRET', nil),
        'none'
      )
    end
  end
end
