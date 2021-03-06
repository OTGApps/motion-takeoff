module Takeoff
  class Reminders

    class << self
      def setup
        version_components = Device.ios_version.split '.'
        if version_components[0].to_i >= 8
          types = UIUserNotificationTypeSound | UIUserNotificationTypeBadge | UIUserNotificationTypeAlert
          notificationSettings = UIUserNotificationSettings.settingsForTypes(types, categories:nil)
          UIApplication.sharedApplication.registerUserNotificationSettings(notificationSettings)
        else
          UIApplication.sharedApplication.registerForRemoteNotificationTypes((UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert))
        end
      end

      def schedule (opts)
        raise "You must specify a :body" unless opts[:body]
        raise "You must specify a :fire_date" unless opts[:fire_date]

        opts = {
          action: nil,
          launch_image: nil,
          badge_number: 0,
          has_action: true,
          repeat: {
            calendar: nil,
            interval: 0
          },
          time_zone: NSTimeZone.defaultTimeZone,
          sound: UILocalNotificationDefaultSoundName,
          user_info: {}

        }.merge(opts)

        # Fix the repeat if they just send the interval.
        unless opts[:repeat].is_a? Hash
          opts[:repeat] = {
            calendar: NSCalendar.currentCalendar,
            interval: opts[:repeat]
          }
        end
        # Interpret the fire date to an NSDate class it they specified a number of seconds
        if opts[:fire_date].is_a? Fixnum
          opts[:fire_date] = NSDate.dateWithTimeIntervalSinceNow(opts[:fire_date])
        end

        notification = UILocalNotification.new.tap do |notif|
          notif.alertAction = opts[:action]
          notif.alertBody = opts[:body]
          notif.alertLaunchImage = opts[:launch_image]
          notif.applicationIconBadgeNumber = opts[:badge_number]
          notif.timeZone = opts[:time_zone]
          notif.fireDate = opts[:fire_date]
          notif.hasAction = opts[:has_action]
          notif.repeatCalendar = opts[:repeat][:calendar]
          notif.repeatInterval = opts[:repeat][:interval]
          notif.soundName = opts[:sound]
          notif.userInfo = opts[:user_info]
        end
        UIApplication.sharedApplication.scheduleLocalNotification notification

        notification
      end

      def reset
        UIApplication.sharedApplication.tap do |app|
          app.applicationIconBadgeNumber = 0
          app.cancelAllLocalNotifications
        end
      end

      def all
        UIApplication.sharedApplication.scheduledLocalNotifications
      end

      def count
        all.count
      end

      def notifications
        all
      end
    end
  end
end
