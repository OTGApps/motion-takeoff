describe "Reminders Spec" do

  before do
    Takeoff::Reminders.setup
    Takeoff::Reminders.reset
    @default = {
      body: "Specs are awesome",
      fire_date: 10
    }
  end

  after do
    Takeoff::Reminders.reset
  end

  it "raises error when no body" do
    should.raise { Takeoff::Reminders.schedule(@default.except(:fire_date)) }
  end

  it "raises error when no fire_date" do
    should.raise { Takeoff::Reminders.schedule(@default.except(:body)) }
  end

  it "should create a notification" do
    Takeoff::Reminders.schedule(@default)
    UIApplication.sharedApplication.scheduledLocalNotifications.count.should == 1
  end

  it "should create multiple notifications" do
    Takeoff::Reminders.schedule(@default)
    Takeoff::Reminders.schedule(@default.merge({fire_date: 20}))
    UIApplication.sharedApplication.scheduledLocalNotifications.count.should == 2
  end

  it "should clear all notifications" do
    Takeoff::Reminders.schedule(@default)
    Takeoff::Reminders.schedule(@default.merge({fire_date: 20}))
    UIApplication.sharedApplication.scheduledLocalNotifications.count.should == 2
    Takeoff::Reminders.reset
    UIApplication.sharedApplication.scheduledLocalNotifications.count.should == 0
  end

  it "should accept an integer for Time" do
    Takeoff::Reminders.schedule(@default)
    notification = UIApplication.sharedApplication.scheduledLocalNotifications.first
    notification.fireDate.is_a?(NSDate).should.be.true
  end

  it "should accept a Time object" do
    Takeoff::Reminders.schedule(@default.merge({fire_date: Time.now + 20}))
    notification = UIApplication.sharedApplication.scheduledLocalNotifications.first
    notification.fireDate.is_a?(NSDate).should.be.true
  end

  it "should properly set the body of the message" do
    Takeoff::Reminders.schedule(@default)
    notification = UIApplication.sharedApplication.scheduledLocalNotifications.first
    notification.alertBody.should == @default[:body]
  end

  it "should set the action" do
    action = "Do It!"
    Takeoff::Reminders.schedule(@default.merge({action: action}))
    notification = UIApplication.sharedApplication.scheduledLocalNotifications.first
    notification.alertAction.should == action
  end

  it "should allow repeating" do
    Takeoff::Reminders.schedule(@default.merge({repeat: NSMinuteCalendarUnit}))
    notification = UIApplication.sharedApplication.scheduledLocalNotifications.first
    notification.repeatInterval.should == NSMinuteCalendarUnit
  end

  it "should set a sound file name" do
    sound = "alert"
    Takeoff::Reminders.schedule(@default.merge({sound: sound}))
    notification = UIApplication.sharedApplication.scheduledLocalNotifications.first
    notification.soundName.should == sound
  end

  it "should set the user_info object" do
    user_info = {name: "Mark Rickert", project: "motion-takeoff"}
    Takeoff::Reminders.schedule(@default.merge({user_info: user_info}))
    notification = UIApplication.sharedApplication.scheduledLocalNotifications.first
    notification.userInfo.should == user_info.stringify_keys
  end

  it "should report number of notifications" do
    Takeoff::Reminders.schedule(@default)
    count = UIApplication.sharedApplication.scheduledLocalNotifications.count
    Takeoff::Reminders.count.should == count
  end

  it "should expose notifications" do
    Takeoff::Reminders.schedule(@default)
    notification = Takeoff::Reminders.notifications.first
    notification.alertBody.should == "Specs are awesome"
  end

  #TODO: Add more tests!
end
