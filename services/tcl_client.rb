# frozen_string_literal: true

require 'faraday'

# TODO: rewrite with use call method
class TclClient
  class << self
    def get_projects(access_token: String)
      response = Faraday.new(
        url: "#{ENV.fetch('TCL_DOMAIN', '')}/webhooks/slack/list_projects",
        params: {},
        headers: { 'Authorization' => "Bearer #{access_token}" }
      )

      JSON.parse(response.get.body)
    end

    def link_project(access_token: String, project_key: String)
      request = Faraday.new(
        url: "#{ENV.fetch('TCL_DOMAIN', '')}/webhooks/slack/link_project",
        params: { project_key: },
        headers: { 'Authorization' => "Bearer #{access_token}" }
      )

      JSON.parse(request.post.body)
    end

    def unlink_project(access_token: String, project_key: String)
      request = Faraday.new(
        url: "#{ENV.fetch('TCL_DOMAIN', '')}/webhooks/slack/unlink_project",
        params: { project_key: },
        headers: { 'Authorization' => "Bearer #{access_token}" }
      )

      JSON.parse(request.delete.body)
    end

    def list_event_notifications(access_token: String, project_key: String)
      request = Faraday.new(
        url: "#{ENV.fetch('TCL_DOMAIN', '')}/webhooks/slack/list_event_notifications",
        params: { project_key: },
        headers: { 'Authorization' => "Bearer #{access_token}" }
      )

      JSON.parse(request.get.body)
    end

    def change_status_event(access_token: String, project_key: String, event: String, status: String)
      request = Faraday.new(
        url: "#{ENV.fetch('TCL_DOMAIN', '')}/webhooks/slack/change_status_event",
        params: { project_key:, event:, status: },
        headers: { 'Authorization' => "Bearer #{access_token}" }
      )

      JSON.parse(request.post.body)
    end
  end
end
