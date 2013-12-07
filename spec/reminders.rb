describe "Reminders Spec" do

  before do
    MotionTakeoff::Reminders.reset
    @body = "Specs are awesome"
    @action = "Do It!"
  end

  after do
    MotionTakeoff::Reminders.reset
  end

  it "raises error when no body" do
    should.raise { MotionTakeoff::Reminders.schedule(fire_date: 10) }
  end

  it "raises error when no fire_date" do
    should.raise { MotionTakeoff::Reminders.schedule(body: @body) }
  end

  it "should create a notification" do
    MotionTakeoff::Reminders.schedule(
      body: @body,
      fire_date: 10
    )
    UIApplication.sharedApplication.scheduledLocalNotifications.count.should == 1
  end

  it "should create multiple notifications" do
    MotionTakeoff::Reminders.schedule(
      body: @body,
      fire_date: 10
    )
    MotionTakeoff::Reminders.schedule(
      body: @body,
      fire_date: 20
    )
    UIApplication.sharedApplication.scheduledLocalNotifications.count.should == 2
  end

  it "should clear all notifications" do
    MotionTakeoff::Reminders.schedule(
      body: @body,
      fire_date: 10
    )
    MotionTakeoff::Reminders.schedule(
      body: @body,
      fire_date: 20
    )
    UIApplication.sharedApplication.scheduledLocalNotifications.count.should == 2
    MotionTakeoff::Reminders.reset
    UIApplication.sharedApplication.scheduledLocalNotifications.count.should == 0
  end

  it "should accept an integer for Time" do
    MotionTakeoff::Reminders.schedule(
      body: @body,
      fire_date: 20
    )
    notification = UIApplication.sharedApplication.scheduledLocalNotifications.first
    notification.fireDate.is_a?(NSDate).should.be.true
  end

  it "should accept a Time object" do
    MotionTakeoff::Reminders.schedule(
      body: @body,
      fire_date: Time.now + 20
    )
    notification = UIApplication.sharedApplication.scheduledLocalNotifications.first
    notification.fireDate.is_a?(NSDate).should.be.true
  end

  it "should properly set the body of the message" do
    MotionTakeoff::Reminders.schedule(
      body: @body,
      fire_date: Time.now + 20
    )
    notification = UIApplication.sharedApplication.scheduledLocalNotifications.first
    notification.alertBody.should == @body
  end

  it "should set the action" do
    MotionTakeoff::Reminders.schedule(
      body: @body,
      fire_date: Time.now + 20,
      action: @action
    )
    notification = UIApplication.sharedApplication.scheduledLocalNotifications.first
    notification.alertAction.should == @action
  end

  it "should allow repeating" do
    MotionTakeoff::Reminders.schedule(
      body: @body,
      fire_date: Time.now + 20,
      repeat: NSMinuteCalendarUnit
    )
    notification = UIApplication.sharedApplication.scheduledLocalNotifications.first
    notification.repeatInterval.should == NSMinuteCalendarUnit
  end

  it "should set a sound file anme" do
    sound = "alert"
    MotionTakeoff::Reminders.schedule(
      body: @body,
      fire_date: Time.now + 10,
      sound: sound
    )
    notification = UIApplication.sharedApplication.scheduledLocalNotifications.first
    notification.soundName.should == sound
  end

  #TODO: Add more tests!
end
