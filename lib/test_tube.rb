# frozen_string_literal: true

require_relative File.join("test_tube", "invoker")
require_relative File.join("test_tube", "passer")

# Namespace for the TestTube library.
module TestTube
  # @param input      [#call]       The callable object to test.
  # @param isolation  [Boolean]     Compute in isolation or not.
  # @param matcher    [#matches?]   A matcher.
  # @param negate     [Boolean]     Invert the matcher or not.
  #
  # @example
  #   invoke(
  #     -> { "101010".to_i(2) },
  #     isolation: false,
  #     matcher:   BeTheAnswer.new,
  #     negate:    false
  #   )
  #
  # @return [Invoker] A software experiment.
  def self.invoke(input, isolation:, matcher:, negate:)
    Invoker.new(input, isolation: isolation, matcher: matcher, negate: negate)
  end

  # @param input      [#object_id]  The callable object to test.
  # @param matcher    [#matches?]   A matcher.
  # @param negate     [Boolean]     Invert the matcher or not.
  #
  # @example
  #   pass(
  #     "101010".to_i(2),
  #     matcher:   BeTheAnswer.new,
  #     negate:    false
  #   )
  #
  # @return [Passer] A software experiment.
  def self.pass(input, matcher:, negate:)
    Passer.new(input, matcher: matcher, negate: negate)
  end
end
