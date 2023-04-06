# frozen_string_literal: true

require 'sinatra'
require 'jwt'

require 'dotenv'
Dotenv.load

require_relative 'services/slack_client'
require_relative 'services/tcl_client'
require_relative 'services/prepare_message_service'
require_relative 'services/jwt_service'
require_relative 'services/validator'

before { @access_token = JwtService.generate_token(params:) }

post '/help' do
  SlackClient.send_message(
    channel: params[:channel_id],
    message: PrepareMessageService.help
  )
end

post '/login' do
  params[:external_user_id] = params.delete(:user_id)
  code = JWT.encode(params, ENV.fetch('TCL_SECRET', nil), 'none')
  link = "#{ENV.fetch('TCL_DOMAIN', '')}/users/sign_in?code=#{code}"

  SlackClient.send_message(channel: params[:channel_id], message: link)
end

post '/list_projects' do
  response = TclClient.get_projects(access_token: @access_token)
  message = PrepareMessageService.list_projects(response:)

  SlackClient.send_message(channel: params[:channel_id], message:)
end

post '/link_project' do
  project_key = params[:text].split.first
  response = TclClient.link_project(access_token: @access_token, project_key:)
  message = PrepareMessageService.link_project(response:)

  SlackClient.send_message(channel: params[:channel_id], message:)
end

post '/unlink_project' do
  project_key = params[:text].split.first
  response = TclClient.unlink_project(access_token: @access_token, project_key:)
  message = PrepareMessageService.unlink_project(response:)

  SlackClient.send_message(channel: params[:channel_id], message:)
end

post '/list_event_notifications' do
  project_key = params[:text].split.first
  response = TclClient.list_event_notifications(access_token: @access_token, project_key:)
  message = PrepareMessageService.list_event_notifications(response:)

  SlackClient.send_message(channel: params[:channel_id], message:)
end

post '/change_status_event' do
  return unless Validator.length?(params:, length: 2)

  tcl_params = params[:text].split
  response = TclClient.change_status_event(
    access_token: @access_token,
    project_key: tcl_params[0],
    event: tcl_params[1]
  )

  message = PrepareMessageService.change_status_event(response:)
  SlackClient.send_message(channel: params[:channel_id], message:)
end
