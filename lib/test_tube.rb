# frozen_string_literal: true

require_relative File.join("test_tube", "invoker")
require_relative File.join("test_tube", "passer")

# Namespace for the TestTube library.
# This library provides two main methods for conducting software experiments:
# - invoke: For testing blocks of code, with full exception handling
# - pass: For testing direct values, with a simpler and safer approach
#
# @example Using with a testing framework
#   require "test_tube"
#   require "matchi"
#
#   # Testing for exceptions
#   TestTube.invoke(matcher: Matchi::RaiseException.new(SystemExit), negate: false) do
#     exit(true)  # Safely catches the SystemExit
#   end
#
#   # Testing direct values
#   TestTube.pass(42, matcher: Matchi::EqualTo.new(42), negate: false)
#
# @api public
module TestTube
  # Invokes a block for testing.
  # This method should be used when you need to:
  # - Execute and test a block of code
  # - Catch all possible exceptions (including SystemExit)
  # - Handle potentially dangerous operations safely
  #
  # @see TestTube::Invoker#initialize for parameter details
  #
  # @example Testing computation result
  #   require "test_tube"
  #
  #   class BeTheAnswer
  #     def match?
  #       42.equal?(yield)
  #     end
  #   end
  #
  #   experiment = TestTube.invoke(matcher: BeTheAnswer.new, negate: false) do
  #     "101010".to_i(2)
  #   end
  #
  #   experiment.actual  # => 42
  #   experiment.error   # => nil
  #   experiment.got     # => true
  #
  # @return [TestTube::Invoker] A software experiment capturing execution results and any errors
  def self.invoke(...)
    Invoker.new(...)
  end

  # Tests a value directly.
  # This method should be used when you:
  # - Already have the value to test
  # - Don't need to execute potentially dangerous code
  # - Want a simpler and more direct testing approach
  #
  # @see TestTube::Passer#initialize for parameter details
  #
  # @example Testing a direct value
  #   require "test_tube"
  #
  #   class BeTheAnswer
  #     def match?
  #       42.equal?(yield)
  #     end
  #   end
  #
  #   experiment = TestTube.pass("101010".to_i(2),
  #     matcher: BeTheAnswer.new,
  #     negate: false
  #   )
  #
  #   experiment.actual  # => 42
  #   experiment.error   # => nil
  #   experiment.got     # => true
  #
  # @return [TestTube::Passer] A software experiment representing the test result
  def self.pass(...)
    Passer.new(...)
  end
end
