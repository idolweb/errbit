if defined? Noti
  class NotificationServices::NotiService < NotificationService
    Label = "noti"
    Fields += [
      [:api_token, {
        :label       => "API Token",
        :placeholder => "123456789abcdef123456789abcdef"
      }]
    ]

    def check_params
      if Fields.detect {|f| self[f[0]].blank? }
        errors.add :base, 'You must specify your Noti API token'
      end
    end

    def url
      'https://notiapp.com/apps'
    end

    def create_notification(problem)
      # Create a new notification object
      notification = Noti::Notification.new
      notification.title = "#{problem.app.name} #{problem.environment} #{problem.where}"
      notification.text = notification_description(problem)
      notification.url = problem_url(problem)

      # Set the user to send the notification to and deliver it
      notification.deliver_to(api_token)
    end
  end
end
