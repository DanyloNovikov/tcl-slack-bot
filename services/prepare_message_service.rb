# frozen_string_literal: true

class PrepareMessageService
  class << self
    def help
      "/help (instruction)\n" \
      "/login (login to TCL company account and sync Slack to TCL)\n" \
      "/list_projects (show the list of projects of TCL company account)\n" \
      "/link_project [title] (connect Slack to specific project of TCL company account)\n" \
      "/unlink_project [title] (unlink Slack from specific project of TCL company account)\n" \
      "/list_event_notifications (show the list of all possible events to notify about)\n" \
      "/change_status_event [eventname] (select/deselect event to notify about)"
    end

    def list_projects(response:)
      return response['error'] if present_error?(response)

      message = ''
      response.each do |project|
        message += "Project name: #{project['name']} - key: #{project['key']}\n"
      end

      message
    end

    def link_project(response:)
      return response['error'] if present_error?(response)

      "Success connect: #{response['project_name']}."
    end

    def unlink_project(response:)
      return response['error'] if present_error?(response)

      "Success disconnect: #{response['project_name']}."
    end

    def list_event_notifications(response:)
      return response['error'] if present_error?(response)

      message = ''
      response['events'].each { |k, v| message += "#{k}: #{v}\n" }
      message
    end

    def change_status_event(response:)
      return response['error'] if present_error?(response)

      'Success changed status event.'
    end

    private

    def present_error?(response)
      return true if response.class != Array && !response['error'].nil?

      false
    end
  end
end
