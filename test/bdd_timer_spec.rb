require 'eventmachine'
require File.dirname(__FILE__) + '/../lib/em-spec/bdd_timer'

module EventMachine
  describe BddTimer, "#em_bdd_timer when no timer is set" do
    include EventMachine::BddTimer

    it "should return the value nil before the timer is added" do
      em_mock = mock(::EM)
      em_mock.should_not_receive(:add_timer)
      em_bdd_timer.should be_nil
    end
  end
  describe BddTimer, "#em_bdd_cancel_timer when no timer is set" do
    include EventMachine::BddTimer

    it "should not try to cancel the timer before it is set" do
      em_mock = mock(::EM)
      stub!(:em_bdd_timer).and_return(nil)
      em_mock.should_not_receive(:cancel_timer)
      em_bdd_cancel_timer.should be_nil
    end

#    it "should cancel the timer once it is set" do
#      em_mock = mock(::EM)
#      stub!(:em_bdd_timer).and_return(5)
#      em_mock.should_receive(:cancel_timer).once.with(an_instance_of(Fixnum))
#      em_bdd_cancel_timer.should be_nil
#    end

  end
end
