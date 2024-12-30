# frozen_string_literal: true

require "simplecov"

SimpleCov.command_name "Brutal test suite"
SimpleCov.start

require_relative "../lib/test_tube"

module Matcher
  class BeTheAnswer
    def match?
      expected.equal?(yield)
    end

    private

    def expected
      42
    end
  end

  class RaiseException
    def initialize(expected)
      @expected = expected
    end

    def match?(*, **)
      yield
    rescue expected => _e
      true
    else
      false
    end

    private

    attr_reader :expected
  end
end
