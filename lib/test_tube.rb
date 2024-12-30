# frozen_string_literal: true

require_relative File.join("test_tube", "invoker")
require_relative File.join("test_tube", "passer")

# Namespace for the TestTube library.
#
# @api public
module TestTube
  # Invokes a block for testing.
  #
  # @see TestTube::Invoker#initialize for parameter details
  #
  # @example
  #   require "test_tube"
  #
  #   class BeTheAnswer
  #     def match?
  #       42.equal?(yield)
  #     end
  #   end
  #
  #   TestTube.invoke(matcher: BeTheAnswer.new, negate: false) do
  #     "101010".to_i(2)
  #   end
  #
  # @return [TestTube::Invoker] A software experiment.
  def self.invoke(...)
    Invoker.new(...)
  end

  # Tests a value directly.
  #
  # @see TestTube::Passer#initialize for parameter details
  #
  # @example
  #   require "test_tube"
  #
  #   class BeTheAnswer
  #     def match?
  #       42.equal?(yield)
  #     end
  #   end
  #
  #   TestTube.pass("101010".to_i(2),
  #     matcher: BeTheAnswer.new,
  #     negate: false
  #   )
  #
  # @return [TestTube::Passer] A software experiment.
  def self.pass(...)
    Passer.new(...)
  end
end
