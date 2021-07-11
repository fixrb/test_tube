# frozen_string_literal: true

require_relative File.join("test_tube", "invoker")
require_relative File.join("test_tube", "passer")

# Namespace for the TestTube library.
#
# @api public
module TestTube
  # @param isolation  [Boolean]     Compute in isolation or not.
  # @param matcher    [#matches?]   A matcher.
  # @param negate     [Boolean]     Invert the matcher or not.
  # @param input      [Proc]        The callable object to test.
  #
  # @example
  #   require "test_tube"
  #
  #   class BeTheAnswer
  #     def matches?
  #       42.equal?(yield)
  #     end
  #   end
  #
  #   TestTube.invoke(isolation: false, matcher: BeTheAnswer.new, negate: false) do
  #     "101010".to_i(2)
  #   end
  #
  # @return [Invoker] A software experiment.
  def self.invoke(isolation:, matcher:, negate:, &input)
    Invoker.new(isolation: isolation, matcher: matcher, negate: negate, &input)
  end

  # @param input      [#object_id]  The callable object to test.
  # @param matcher    [#matches?]   A matcher.
  # @param negate     [Boolean]     Invert the matcher or not.
  #
  # @example
  #   require "test_tube"
  #
  #   class BeTheAnswer
  #     def matches?
  #       42.equal?(yield)
  #     end
  #   end
  #
  #   TestTube.pass("101010".to_i(2),
  #     matcher: BeTheAnswer.new,
  #     negate: false
  #   )
  #
  # @return [Passer] A software experiment.
  def self.pass(input, matcher:, negate:)
    Passer.new(input, matcher: matcher, negate: negate)
  end
end
