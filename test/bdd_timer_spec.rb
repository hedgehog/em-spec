require 'eventmachine'
require File.dirname(__FILE__) + '/../lib/em-spec/rspec'
require File.dirname(__FILE__) + '/../lib/em-spec/bdd_timer'

module EventMachine
  describe BddTimer, "#em_bdd_timer with no timer set" do
    include ::EventMachine::BddTimer

    it "should return the value nil before the timer is added" do
      ::EM.should_not_receive(:add_timer)
      em_bdd_timer.should be_nil
    end
  end
  describe BddTimer, "#em_bdd_cancel_timer with no timer set" do
    include ::EventMachine::BddTimer

    it "should not try to cancel the timer before it is set" do
      self.em_bdd_timer = nil
      ::EM.should_not_receive(:cancel_timer)
      em_bdd_cancel_timer.should be_nil
    end

    it "should cancel the timer once it is set" do
      self.em_bdd_timer = "not nil or false"
      ::EM.should_receive(:cancel_timer).once
      em_bdd_cancel_timer.should be_nil
    end

  end

  describe BddTimer, "#em_bdd_timeout with no timer set" do
    include ::EventMachine::BddTimer

    it "should not cancel timer when no timeout is set" do
      t=1
      self.em_bdd_timer=nil
      ::EM.should_not_receive(:cancel_timer)
      ::EM.stub!(:add_timer)
      em_bdd_timeout(t)
    end
    it "should add timer when no timeout is set" do
      t=5 
      self.em_bdd_timer =nil
      ::EM.should_receive(:add_timer).with(an_instance_of(Fixnum)).once
      em_bdd_timeout(t) 
    end
  end

  describe BddTimer, "#em_bdd_timeout with timer set" do
    include ::EventMachine::BddTimer

    it "should cancel timer when timeout has been set" do
      t=5
      self.em_bdd_timer = "not nil or false"
      ::EM.should_receive(:cancel_timer).once
      ::EM.should_receive(:add_timer).with(an_instance_of(Fixnum)).once
      em_bdd_timeout(t)
    end

  end
  
#    it "should add timer when no timeout is set" do
#      t=1
#      em_mock = mock(::EM)
#      stub!(:em_bdd_timer).and_return(nil)
#      em_mock.should_receive(:add_timer).once.with(an_instance_of(Fixnum))
#      em { em_bdd_timeout(t).should == "" }
#    end

end
