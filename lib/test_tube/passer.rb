# frozen_string_literal: true

require_relative "base"

module TestTube
  # The passer class is great for values.
  class Passer < Base
    # Software experiments.
    #
    # @param input    [#object_id]  An actual value to test.
    # @param matcher  [#matches?]   A matcher.
    # @param negate   [Boolean]     Invert the matcher or not.
    def initialize(input, matcher:, negate:)
      super()

      @actual = input
      @got = negate ^ matcher.matches? { input }
    end
  end
end
