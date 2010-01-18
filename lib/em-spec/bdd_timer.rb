module EventMachine
  module BddTimer
    BddTimeoutExceededError = Class.new(::RuntimeError)

    attr_accessor :em_bdd_timer

    def em_bdd_cancel_timer
      EM.cancel_timer(em_bdd_timer) if em_bdd_timer
    end

    def em_bdd_timeout(time_to_run)
      em_bdd_cancel_timer
      em_bdd_timer=::EM.add_timer(time_to_run) { done; raise BddTimeoutExceededError.new }
    end

    def self.em_bdd_default_timeout(time_to_run)
      @em_default_time_to_finish = time_to_run
    end
  end
end
