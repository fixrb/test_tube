# frozen_string_literal: true

require "defi/method"

require_relative "base"

module TestTube
  # Evaluate an actual value invoking it with #call method.
  #
  # @api private
  class Invoker < Base
    # rubocop:disable Lint/RescueException

    # Class initializer.
    #
    # @param matcher  [#matches?] A matcher.
    # @param negate   [Boolean]   Invert the matcher or not.
    # @param input    [Proc]      The callable object to test.
    def initialize(matcher:, negate:, &input)
      super()

      @got = negate ^ matcher.matches? do
        value = send_call.to(input)
        @actual = value.object
        value.call
      end
    rescue ::Exception => e
      @actual = nil
      @error  = e
    end

    # rubocop:enable Lint/RescueException

    private

    # @return [::Defi::Method] The challenge for the callable object.
    #
    # @see https://github.com/fixrb/defi/blob/v3.0.0/lib/defi/method.rb
    def send_call
      ::Defi::Method.new(:call)
    end
  end
end
