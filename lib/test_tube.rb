# frozen_string_literal: true

require_relative File.join("test_tube", "content")
require_relative File.join("test_tube", "liquid")

# Namespace for the TestTube library.
module TestTube
  # @param input      [#call]     The callable object to test.
  # @param isolation  [Boolean]   Compute in isolation or not.
  # @param matcher    [#matches?] A matcher.
  # @param negate     [Boolean]   Invert the matcher or not.
  #
  # @return [Content] A software experiment.
  def self.content(input, isolation:, matcher:, negate:)
    Content.new(input, isolation: isolation, matcher: matcher, negate: negate)
  end

  # @param input      [#call]     The callable object to test.
  # @param matcher    [#matches?] A matcher.
  # @param negate     [Boolean]   Invert the matcher or not.
  #
  # @return [Content] A software experiment.
  def self.liquid(input, matcher:, negate:)
    Liquid.new(input, matcher: matcher, negate: negate)
  end
end
