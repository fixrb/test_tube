# frozen_string_literal: true

module TestTube
  # Abstract class representing the state and result of a test experiment.
  # This class inherits from BasicObject to provide a minimal interface
  # and avoid any method conflicts with the objects being tested.
  #
  # It provides three main attributes:
  # - actual: The value being tested
  # - error: Any error that occurred during the test
  # - got: The boolean result of the matcher
  #
  # @example Examining a test result
  #   experiment = TestTube.invoke(matcher: SomeMatcher.new, negate: false) { 42 }
  #   experiment.actual # => 42
  #   experiment.error  # => nil
  #   experiment.got    # => true
  #
  # @api private
  class Experiment < ::BasicObject
    # Expectation's actual value.
    # This represents the value that was actually produced during the test,
    # whether it came from a direct value (Passer) or a block execution (Invoker).
    #
    # @return [Object] The actual value being tested
    # @return [nil] If an error occurred during the test
    #
    # @api public
    attr_reader :actual

    # Expectation's raised error.
    # Stores any exception that occurred during the test execution,
    # including system-level exceptions (SystemExit, SignalException, etc.)
    # when using Invoker.
    #
    # @return [Exception, nil] Any error that occurred during the test
    #
    # @api public
    attr_reader :error

    # Expectation's returned boolean value.
    # The result of applying the matcher to the actual value.
    # Will be nil if an error occurred during the test.
    #
    # @return [Boolean] true if the matcher matched (considering negate)
    # @return [nil] if an error occurred during the test
    #
    # @api public
    attr_reader :got

    # A string containing a human-readable representation of the experiment.
    # Useful for debugging and logging test results.
    #
    # @example
    #   experiment.inspect
    #   # => "<TestTube actual=42 error=nil got=true>"
    #
    # @return [String] Human-readable representation of the experiment
    #
    # @api public
    def inspect
      "<TestTube actual=#{actual.inspect} error=#{error.inspect} got=#{got.inspect}>"
    end

    alias to_s inspect

    private

    # Validates that the provided matcher responds to match?.
    # This is crucial as the matcher is the core of the testing mechanism.
    #
    # @param matcher [Object] The matcher to validate
    # @raise [ArgumentError] If the matcher doesn't respond to match?
    #
    # @api private
    def validate_matcher(matcher)
      raise ::ArgumentError, "Matcher must respond to match?" unless matcher.respond_to?(:match?)
    end

    # Validates that the negate parameter is strictly boolean.
    # This ensures predictable test behavior.
    #
    # @param negate [Object] The value to validate
    # @raise [ArgumentError] If the value isn't true or false
    #
    # @api private
    def validate_negate(negate)
      raise ::ArgumentError, "negate must be boolean" unless [true, false].include?(negate)
    end
  end
end
