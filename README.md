# motion-takeoff

A RubyMotion specific iOS gem that helps you do things at launch.

Currently, there is only one module in this gem: `Messages`. The `Messages` module will allow you to schedule alerts to users at certain launch counts. More modules are planned for the future.

This gem is in its infancy. Please help me make it better!

## Installation

Add this line to your application's Gemfile:

    gem 'motion-takeoff'

And run: `bundle`

## Usage: Messages Module

Open your app delegate and in your `applicationDidBecomeActive:` method do something like this:

```ruby
def applicationDidBecomeActive(application)
  messages = MotionTakeoff::Messages.new
  messages.message launch:1, title:"Welcome to #{App.name}!", message:"Thanks for checking it out!"
  messages.message launch:3, title:"Quick Tip:", message:"This is the 3rd time you've launched this application!"
  messages.message launch:500, title:"Quick Tip:", message:"This is the 500th time you've launched this application!"
  messages.takeoff
end
```
This will display an alert to the user on the 1st, 3rd, and 500th launches of the app.

## Future plans

I'd like it to be able to be a multi-purpose tool for doing things at launch other than just alerting users. Things like asking for ratings in the iTunes store and scheduling other activities likes clearing caches on the 10th load or checking a server every load, etc.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
