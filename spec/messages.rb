describe "Messages Spec" do

  before do
    @launch_count_key = 'motion_takeoff_launch_count'
    App::Persistence[@launch_count_key] = nil # Reset Launch Count

    @defaults = {
      message: "Message",
      title: "Title",
      launch: 2
    }
  end

  it "launch count should be nil on first launch" do
    App::Persistence[@launch_count_key].should.be.nil
  end

  it "should increment launch count when initialized" do
    MotionTakeoff::Messages.new
    App::Persistence[@launch_count_key].should == 1
  end

  it "should increment launch count every time" do
    MotionTakeoff::Messages.new
    App::Persistence[@launch_count_key].should == 1
    MotionTakeoff::Messages.new
    App::Persistence[@launch_count_key].should == 2
    MotionTakeoff::Messages.new
    App::Persistence[@launch_count_key].should == 3
    MotionTakeoff::Messages.new
    App::Persistence[@launch_count_key].should == 4
  end

  it "raises error when no launch number" do
    should.raise do
      m = MotionTakeoff::Messages.new
      m.schedule(@defaults.except(:launch))
    end
  end

  it "raises error when no message" do
    should.raise do
      m = MotionTakeoff::Messages.new
      m.schedule(@defaults.except(:message))
    end
  end

  it "raises error when no title" do
    should.raise do
      m = MotionTakeoff::Messages.new
      m.schedule(@defaults.except(:title))
    end
  end

  it "should initialize with no messages" do
      m = MotionTakeoff::Messages.new
      m.messages.is_a?(Array).should.be.true
      m.messages.count.should == 0
  end


  it "should properly schedule a message" do
      m = MotionTakeoff::Messages.new
      m.schedule(@defaults)
      m.messages.count.should == 1
  end

  it "should properly schedule multiple messages" do
      m = MotionTakeoff::Messages.new
      m.schedule(@defaults)
      m.schedule(@defaults)
      m.messages.count.should == 2
  end

  #TODO: Add more tests!
end
