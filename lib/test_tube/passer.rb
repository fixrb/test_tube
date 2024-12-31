# frozen_string_literal: true

require_relative "experiment"

module TestTube
  # Evaluate an actual value passed in parameter.
  # Unlike Invoker, this class handles direct value testing without executing a block,
  # making it safer when you already have the value to test.
  #
  # @example Testing a direct value
  #   TestTube.pass("101010".to_i(2),
  #     matcher: BeTheAnswer.new,
  #     negate: false
  #   )
  #
  # @api private
  class Passer < Experiment
    # Class initializer.
    # Validates the matcher and negate parameter before performing the test.
    # Since no code block is executed, this approach is immune to system-level
    # exceptions that might occur during value computation.
    #
    # @param input    [Object]  The actual value to test
    # @param matcher  [#match?] The matcher to evaluate the result
    # @param negate   [Boolean] Whether to invert the matcher result
    # @raise [ArgumentError]    If the matcher doesn't respond to match?
    def initialize(input, matcher:, negate:)
      validate_matcher(matcher)
      validate_negate(negate)
      super()
      @actual = input
      @got = negate ^ matcher.match? { input }
    end
  end
end
