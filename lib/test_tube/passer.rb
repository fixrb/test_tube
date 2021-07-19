# frozen_string_literal: true

require_relative "base"

module TestTube
  # Evaluate an actual value passed in parameter.
  #
  # @api private
  class Passer < Base
    # Class initializer.
    #
    # @param input    [#object_id]  The actual value to test.
    # @param matcher  [#matches?]   A matcher.
    # @param negate   [Boolean]     Invert the matcher or not.
    def initialize(input, matcher:, negate:)
      super()

      @actual = input
      @got = negate ^ matcher.matches? { input }
    end
  end
end
