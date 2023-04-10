# frozen_string_literal: true
require 'dotenv'
Dotenv.load

class JwtService
  class << self
    def generate_token(params, exp = ENV.fetch('EXPIRE_TIME', 1682444575).to_i)
      params[:external_user_id] = params.delete(:user_id)
      params[:exp] = exp
      JWT.encode(
        params.slice(:external_user_id, :channel_id, :exp),
        ENV.fetch('TCL_SECRET', nil),
        'none'
      )
    end
  end
end
