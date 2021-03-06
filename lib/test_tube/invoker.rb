# frozen_string_literal: true

require "defi"

require_relative "base"

module TestTube
  # Evaluate an actual value invoking it with #call method.
  #
  # @api private
  class Invoker < Base
    # rubocop:disable Lint/RescueException, Metrics/MethodLength

    # Class initializer.
    #
    # @param isolate  [Boolean]   Compute in a subprocess.
    # @param matcher  [#matches?] A matcher.
    # @param negate   [Boolean]   Invert the matcher or not.
    # @param input    [Proc]      The callable object to test.
    def initialize(isolate:, matcher:, negate:, &input)
      super()

      @got = negate ^ matcher.matches? do
        value = if isolate
                  send_call.to!(input)
                else
                  send_call.to(input)
                end

        @actual = value.object
        value.call
      end
    rescue ::Exception => e
      @actual = nil
      @error  = e
    end

    # rubocop:enable Lint/RescueException, Metrics/MethodLength

    private

    # @return [::Defi::Challenge] The challenge for the callable object.
    #
    # @see https://github.com/fixrb/defi/blob/v2.0.5/lib/defi/challenge.rb
    def send_call
      ::Defi.send(:call)
    end
  end
end
