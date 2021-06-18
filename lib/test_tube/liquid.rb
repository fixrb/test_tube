# frozen_string_literal: true

require_relative "base"

module TestTube
  # The liquid class is great for values.
  class Liquid < Base
    # Software experiments.
    #
    # @param input    [#object_id]  An actual value to test.
    # @param matcher  [#matches?]   A matcher.
    # @param negate   [Boolean]     Invert the matcher or not.
    def initialize(input, matcher:, negate:)
      super()

      @actual = input
      @got = negate ^ matcher.matches? { @actual }
    end
  end
end
