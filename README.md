# motion-takeoff [![Build Status](https://travis-ci.org/MohawkApps/motion-takeoff.png)](https://travis-ci.org/MohawkApps/motion-takeoff) [![Code Climate](https://codeclimate.com/github/MohawkApps/motion-takeoff.png)](https://codeclimate.com/github/MohawkApps/motion-takeoff) [![Gem Version](https://badge.fury.io/rb/motion-takeoff.png)](http://badge.fury.io/rb/motion-takeoff)

A RubyMotion specific iOS gem for scheduling stuff. You can use motion-takeoff to display messages at certain launch counts and schedule local notifications. Currently, there are two modules in this gem: `Messages` & `Reminders`.

The `Messages` module will allow you to schedule alerts to users at certain launch counts.

The `Reminders` module is a nice wrapper for `UILocalNotification` to help you set reminders for the user to come back to your app at specified periods of time. It supports all the options of `UILocalNotification` and does some fancy interpretation of dates for you if needed.

More modules are planned for the future. This gem is in its infancy. Please help me make it better!

## Installation

Add this line to your application's Gemfile:

    gem 'motion-takeoff'

And run: `bundle`

## Usage: Messages Module

Open your app delegate and in your `applicationDidBecomeActive:` method do something like this:

```ruby
def applicationDidBecomeActive(application)
  messages = Takeoff::Messages.new
  messages.schedule launch:1, title:"Welcome to #{App.name}!", message:"Thanks for checking it out!"
  messages.schedule launch:3, title:"Quick Tip:", message:"This is the 3rd time you've launched this application!"
  messages.schedule launch:500, title:"Quick Tip:", message:"This is the 500th time you've launched this application!"
  messages.takeoff
end
```
This will display an alert to the user on the 1st, 3rd, and 500th launches of the app.

## Usage: Reminder Module

The reminders module is a nice wrapper on `UILocalNotification` and makes it easy to schedule reminders to come back and use your app!

You should always reset all local notifications when your app becomes active:

```ruby
def applicationDidBecomeActive(application)
  Takeoff::Reminders.reset
end
```

And here's how to set multiple reminders when your app enters the background:

```ruby
def applicationDidEnterBackground(application)
  Takeoff::Reminders.schedule(
    body: "Fires 20 seconds after the user closes your app.",
    fire_date: 20 #seconds
  )

  Takeoff::Reminders.schedule(
    body: "Fires 10 seconds later.",
    fire_date: Time.now + 30 #Time object in the future
  )
end
```

The `Takeoff::Reminders.schedule` method takes a hash of options that are send to the `UILocalNotification`. `body` and `fire_date` are required and will raise an exception if you try to schedule a notification without those teo options. Here's all the default options:

```ruby
{
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
}
```

You can read about what each of these does in Apple's `UILocalNotification` Documentation, but I've implemented all of Apple's defaults that you can override if needed.

If you pass a `NSCalendarUnit` for the `repeat` option, we'll automatically assume you want to use `NSCalendar.currentCalendar` as the repeat calendar. Possible values of `repeat` are as found in the `NSCalendarUnit` documentation.

## Future plans

I'd like it to be able to be a multi-purpose tool for doing things at launch other than just alerting users. Things like asking for ratings in the iTunes store and scheduling other activities likes clearing caches on the 10th load or checking a server every other load, etc.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

---
[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/MohawkApps/motion-takeoff/trend.png)](https://bitdeli.com/free "Bitdeli Badge")
