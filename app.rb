# frozen_string_literal: true

require 'sinatra'
require 'jwt'

require 'dotenv'
Dotenv.load

require_relative 'services/slack_client'

post '/help' do
end

post '/login' do
  token = JWT.encode(params, ENV.fetch('TCL_SECRET', nil), 'none')
  link = ENV.fetch('PROD_LOGIN', nil) + "?token=#{token}"

  SlackClient.send_message(
    channel: params[:channel_name],
    message: link
  )
end

post '/link_project' do
end

post 'unlink_project' do
end
