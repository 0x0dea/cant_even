module CantEven
  ParityError = Class.new Exception
  EscapeHatch = :i_suck_and_my_program_really_needs_to_even

  # TODO: Moar!
  NOPES = [
    "%<kind>s `%<obj>d' has insufficient oddity.",
    "`%<obj>d' is an inappropriately even %<kind>s.",
    "Do you even %<kind>s? No, `%<obj>d', you don't.",
  ]

  def self.check obj, kind
    if Integer === obj && obj.even?
      raise ParityError,
            NOPES.sample % {obj: obj, kind: kind},
            # Scrub implementation details from the backtrace.
            caller.grep_v(/Deoptimizer/).drop(kind == 'argument' ? 3 : 1)
    end
  end

  # Trace calls and returns, and explode if any evens are involved.
  # Unexported and immediately enabled for maximal topkeks.
  tracer = TracePoint.new(:call, :c_call, :return, :c_return) { |tp|
    case tp.event
    when :call, :c_call
      check tp.self, 'receiver'
      tp.binding.local_variables.each do |lv|
        check tp.binding.local_variable_get(lv), 'argument'
      end
    when :return, :c_return
      check tp.return_value, 'return value'
    end
  }.tap(&:enable)

  # Close over ^ to provide an escape hatch for dire circumstances.
  define_singleton_method(EscapeHatch) { |&block|
    tracer.disable and block.call and tracer.enable
  }

  # `1 + 1` compiles to `opt_plus` and won't be seen by TracePoint
  # as long as Fixnum#+ has its original definition.
  module Deoptimizer
    %i[+ - * / % < <= > >= ==].each do |op|
      define_method(op) { |o| super o }
    end
  end
end

Fixnum.prepend CantEven::Deoptimizer
