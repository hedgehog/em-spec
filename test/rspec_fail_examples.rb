require File.dirname(__FILE__) + '/../lib/em-spec/rspec'

describe EventMachine, "when running failing examples" do
  include EM::Spec
  
  it "should not bubble failures beyond rspec" do
    pending "Needs more - this never passed before so marked pending"
    em do
      EM.add_timer(0.1) do
      raise Spec::Expectations::ExpectationNotMetError
      done
    end
    end.should_not raise Spec::Expectations::ExpectationNotMetError
  end

  it "should not block on failure" do
    pending "Needs more - this actually does hang on failure.  Maybe meant 'on failing rspec's should'?"
    @status = nil
    1 == 2
    @status = "continued" 
    @status.should == "continued"
  end

end