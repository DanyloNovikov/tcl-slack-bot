# frozen_string_literal: true

require 'sinatra'
require 'jwt'

require 'dotenv'
Dotenv.load

require_relative 'services/slack_client'
require_relative 'services/tcl_client'
require_relative 'services/prepare_message_service'

post '/help' do
  message = PrepareMessageService.prepare_help(list: response)
  SlackClient.send_message(
    channel: params[:channel_name],
    message:
  )
end

post '/login' do
  params[:external_user_id] = params.delete(:user_id)
  code = JWT.encode(params, ENV.fetch('TCL_SECRET', nil), 'none')
  link = "#{ENV.fetch('TCL_DOMAIN', '')}/users/sign_in?code=#{code}"

  SlackClient.send_message(
    channel: params[:channel_name],
    message: link
  )
end

post '/list_projects' do
  params[:external_user_id] = params.delete(:user_id)
  token = JWT.encode(
    params.slice(:external_user_id, :channel_id),
    ENV.fetch('TCL_SECRET', nil),
    'none'
  )

  response = TclClient.get_projects(access_token: token)
  message = PrepareMessageService.list_projects(response: response)
  SlackClient.send_message(
    channel: params[:channel_name],
    message:
  )
end

post '/link_project' do
  token = JWT.encode(
    params.slice(:external_user_id, :channel_id),
    ENV.fetch('TCL_SECRET', nil),
    'none'
  )

  response = TclClient.link_project(
    access_token: token,
    project_key: params[:text].split.first
  )

  message = PrepareMessageService.link_project(response: response)
  SlackClient.send_message(
    channel: params[:channel_name],
    message: message 
  )
end

post '/unlink_project' do
  token = JWT.encode(
    params.slice(:external_user_id, :channel_id),
    ENV.fetch('TCL_SECRET', nil),
    'none'
  )

  response = TclClient.unlink_project(
    access_token: token,
    project_key: params[:text].split.first
  )

  message = PrepareMessageService.unlink_project(response: response)
  SlackClient.send_message(
    channel: params[:channel_name],
    message: message 
  )
end

post '/list_event_notifications' do
  token = JWT.encode(
    params.slice(:external_user_id, :channel_id),
    ENV.fetch('TCL_SECRET', nil),
    'none'
  ) 

  response = TclClient.list_event_notifications(
    access_token: token,
    project_key: params[:text].split.first
  )

  message = PrepareMessageService.list_event_notifications(response: response)
  SlackClient.send_message(
    channel: params[:channel_name],
    message: message 
  )
end
