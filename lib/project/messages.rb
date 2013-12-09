module Takeoff
  class Messages
    attr_accessor :messages

    def initialize
      self.messages = []
      @launch_key = 'motion_takeoff_launch_count'
      handle_launch
    end

    def schedule(opts={})
      raise "You must specify a :launch" unless opts[:launch]
      raise "You must specify a :title" unless opts[:title]
      raise "You must specify a :message" unless opts[:message]

      self.messages << opts
    end

    def takeoff
      self.messages.each do |message|
        if message[:launch] == App::Persistence[@launch_key]
          if message.keys.include? :action
            confirm_alert message
          else
            regular_alert message
          end
        end
      end
    end

    private

    def regular_alert message
      App.alert(message[:title], message:message[:message])
    end

    def confirm_alert message
      message = {
        :buttons => ["Cancel", "OK"]
      }.merge(message)

      alert = BW::UIAlertView.default(message) do |alert|
        if alert.clicked_button.title == "OK"
          message[:action].call
        end
      end

      alert.show
    end

    def handle_launch
      if App::Persistence[@launch_key].nil?
        App::Persistence[@launch_key] = 1
      else
        App::Persistence[@launch_key] = App::Persistence[@launch_key] + 1
      end
    end

  end
end

