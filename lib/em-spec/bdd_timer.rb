module EventMachine
  module BddTimer

    attr_accessor :em_bdd_timer

    def em_bdd_cancel_timer
      EM.cancel_timer(em_bdd_timer) if em_bdd_timer
    end

    def em_bdd_timeout(time_to_run)
      em_bdd_cancel_timer
    end

  end
end