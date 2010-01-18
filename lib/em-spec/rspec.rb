require 'eventmachine'
require File.dirname(__FILE__) + '/../ext/fiber18'
require File.dirname(__FILE__) + '/bdd_timer'

module EventMachine
  module SpecHelper
    include ::EventMachine::BddTimer

    SpecTimeoutExceededError = Class.new(RuntimeError)
    
    def self.included(cls)
      ::Spec::Example::ExampleGroup.instance_eval "
      $_em_default_time_to_finish = nil
      def self.default_timeout(timeout)
        $_em_default_time_to_finish = timeout
      end
      "
    end
   
    def em(time_to_run = $_em_default_time_to_finish, &block)
      EM.run do
        em_bdd_timeout(time_to_run)
        em_spec_exception = nil
        @_em_spec_fiber = Fiber.new do
          begin
            block.call
          rescue Exception => em_spec_exception
            done
          end
          Fiber.yield
        end  

        @_em_spec_fiber.resume

        raise em_spec_exception if em_spec_exception
      end
    end

    def done
      em_bdd_cancel_timer
      EM.next_tick{
        finish_em_spec_fiber
      }
    end

    private

    def finish_em_spec_fiber
      EM.stop_event_loop if EM.reactor_running?
      @_em_spec_fiber.resume if @_em_spec_fiber.alive?
    end
    
  end
  
  module Spec

    include SpecHelper

    def instance_eval(&block)
      em do
        super(&block)
      end
    end

  end
  
end


