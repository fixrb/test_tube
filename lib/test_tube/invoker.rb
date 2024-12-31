# frozen_string_literal: true

require "defi/method"

require_relative "experiment"

module TestTube
  # Evaluate an actual value invoking it with #call method.
  # This class is designed to handle ALL possible exceptions during test execution,
  # including system-level exceptions. This is crucial for testing frameworks to:
  # - Capture system exceptions (SystemExit, SignalException, etc.)
  # - Prevent test suite interruption through exit calls
  # - Ensure complete control over the test execution flow
  # - Allow proper reporting of all types of failures
  #
  # @example Handling a system exit
  #   TestTube.invoke(matcher: SomeExitMatcher.new, negate: false) do
  #     exit(true)  # Will be caught and handled properly
  #   end
  #
  # @api private
  class Invoker < Experiment
    # Class initializer.
    #
    # @param matcher  [#match?] The matcher to evaluate the result
    # @param negate   [Boolean] Whether to invert the matcher result
    # @param input    [Proc]    The callable object to test
    # @raise [ArgumentError]    If the matcher doesn't respond to match?
    def initialize(matcher:, negate:, &input)
      validate_matcher(matcher)
      validate_negate(negate)
      super()
      perform_experiment(matcher, negate, input)
    end

    private

    # Executes the experiment and handles any exceptions.
    # Deliberately catches ALL exceptions (including system exceptions) to ensure
    # complete control over the test execution flow.
    #
    # @param matcher [#match?] The matcher to evaluate the result
    # @param negate  [Boolean] Whether to invert the matcher result
    # @param input   [Proc]    The code block to execute
    def perform_experiment(matcher, negate, input)
      @got = evaluate_match(matcher, negate, input)
    rescue ::Exception => e # rubocop:disable Lint/RescueException
      handle_exception(e)
    end

    # Evaluates the match result and handles the actual execution of the test code.
    #
    # @param matcher [#match?] The matcher to evaluate the result
    # @param negate  [Boolean] Whether to invert the matcher result
    # @param input   [Proc]    The code block to execute
    # @return [Boolean] The result of the matcher evaluation
    def evaluate_match(matcher, negate, input)
      negate ^ matcher.match? do
        value = send_call.to(input)
        @actual = value.object
        value.call
      end
    end

    # Handles any exception that occurs during the experiment execution.
    # Sets the actual value to nil and stores the exception.
    #
    # @param error [Exception] The exception that was raised
    def handle_exception(error)
      @actual = nil
      @error = error
    end

    # @return [::Defi::Method] The challenge for the callable object.
    #
    # @see https://github.com/fixrb/defi/blob/v3.0.1/lib/defi/method.rb
    def send_call
      ::Defi::Method.new(:call)
    end
  end
end
