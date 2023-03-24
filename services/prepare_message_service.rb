# frozen_string_literal: true

class PrepareMessageService
  class << self
    def help
      # binding.pry
    end

    def list_projects(response:)
      message = ''
      response.each do |project|
        message += "Project name: #{project['name']} - key: #{project['key']}\n"
      end

      message
    end

    def link_project(response:)
      "Success connect: #{response['project_name']}"
    end

    def unlink_project(response:)
      "Success disconnect: #{response['project_name']}"
    end

    def list_event_notifications(response:)
      response.reject { |k, v| %w[id project_id].include?(k)}
      message = ''
      
      %w[test_cases test_plans test_runs].each do |key|
        message += "#{key}: \n"
        response[key].each do |event, status|
          message += "  #{event}: #{status}\n"
        end
      end

      message
    end
  end
end
