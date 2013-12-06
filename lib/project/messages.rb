module MotionTakeoff
  class Messages

    def initialize
      @messages = []
      @launch_key = 'motion_takeoff_launch_count'
      handle_launch
    end

    def message(opts={})
      @messages << opts
    end

    def takeoff
      @messages.each do |message|
        if message[:launch] == App::Persistence[@launch_key]
          App.alert(message[:title], message:message[:message])
        end
      end
    end

    private
    def handle_launch
      if App::Persistence[@launch_key].nil?
        App::Persistence[@launch_key] = 1
      else
        App::Persistence[@launch_key] = App::Persistence[@launch_key] + 1
      end
    end

  end
end

