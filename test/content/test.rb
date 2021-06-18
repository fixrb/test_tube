#!/usr/bin/env ruby
# frozen_string_literal: true

require "simplecov"

::SimpleCov.command_name "Brutal test suite"
::SimpleCov.start

require "./../../lib/test_tube"

module Matcher
  class BeTheAnswer
    def expected
      42
    end

    def matches?
      expected.equal?(yield)
    end
  end

  class RaiseException
    attr_reader :expected

    def initialize(expected)
      @expected = expected
    end

    def matches?(*, **)
      yield
    rescue expected => _e
      true
    else
      false
    end
  end
end

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { "101010".to_i(2) },
    isolation: false,
    matcher: Matcher::BeTheAnswer.new,
    negate: false
  )
end

raise if actual.actual.class != Integer
raise if actual.error.class != NilClass
raise if actual.got != true

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { "101010".to_i(2) },
    isolation: false,
    matcher: Matcher::BeTheAnswer.new,
    negate: true
  )
end

raise if actual.actual.class != Integer
raise if actual.error.class != NilClass
raise if actual.got != false

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { "101010".to_i(2) },
    isolation: false,
    matcher: Matcher::RaiseException.new(TypeError),
    negate: false
  )
end

raise if actual.actual.class != Integer
raise if actual.error.class != NilClass
raise if actual.got != false

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { "101010".to_i(2) },
    isolation: false,
    matcher: Matcher::RaiseException.new(TypeError),
    negate: true
  )
end

raise if actual.actual.class != Integer
raise if actual.error.class != NilClass
raise if actual.got != true

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { "101010".to_i(2) },
    isolation: false,
    matcher: Matcher::RaiseException.new(ZeroDivisionError),
    negate: false
  )
end

raise if actual.actual.class != Integer
raise if actual.error.class != NilClass
raise if actual.got != false

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { "101010".to_i(2) },
    isolation: false,
    matcher: Matcher::RaiseException.new(ZeroDivisionError),
    negate: true
  )
end

raise if actual.actual.class != Integer
raise if actual.error.class != NilClass
raise if actual.got != true

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { "101010".to_i(2) },
    isolation: true,
    matcher: Matcher::BeTheAnswer.new,
    negate: false
  )
end

raise if actual.actual.class != Integer
raise if actual.error.class != NilClass
raise if actual.got != true

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { "101010".to_i(2) },
    isolation: true,
    matcher: Matcher::BeTheAnswer.new,
    negate: true
  )
end

raise if actual.actual.class != Integer
raise if actual.error.class != NilClass
raise if actual.got != false

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { "101010".to_i(2) },
    isolation: true,
    matcher: Matcher::RaiseException.new(TypeError),
    negate: false
  )
end

raise if actual.actual.class != Integer
raise if actual.error.class != NilClass
raise if actual.got != false

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { "101010".to_i(2) },
    isolation: true,
    matcher: Matcher::RaiseException.new(TypeError),
    negate: true
  )
end

raise if actual.actual.class != Integer
raise if actual.error.class != NilClass
raise if actual.got != true

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { "101010".to_i(2) },
    isolation: true,
    matcher: Matcher::RaiseException.new(ZeroDivisionError),
    negate: false
  )
end

raise if actual.actual.class != Integer
raise if actual.error.class != NilClass
raise if actual.got != false

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { "101010".to_i(2) },
    isolation: true,
    matcher: Matcher::RaiseException.new(ZeroDivisionError),
    negate: true
  )
end

raise if actual.actual.class != Integer
raise if actual.error.class != NilClass
raise if actual.got != true

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { 1 / 0 },
    isolation: false,
    matcher: Matcher::BeTheAnswer.new,
    negate: false
  )
end

raise if actual.actual.class != NilClass
raise if actual.error.class != ZeroDivisionError
raise if actual.got != nil

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { 1 / 0 },
    isolation: false,
    matcher: Matcher::BeTheAnswer.new,
    negate: true
  )
end

raise if actual.actual.class != NilClass
raise if actual.error.class != ZeroDivisionError
raise if actual.got != nil

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { 1 / 0 },
    isolation: false,
    matcher: Matcher::RaiseException.new(TypeError),
    negate: false
  )
end

raise if actual.actual.class != NilClass
raise if actual.error.class != ZeroDivisionError
raise if actual.got != nil

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { 1 / 0 },
    isolation: false,
    matcher: Matcher::RaiseException.new(TypeError),
    negate: true
  )
end

raise if actual.actual.class != NilClass
raise if actual.error.class != ZeroDivisionError
raise if actual.got != nil

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { 1 / 0 },
    isolation: false,
    matcher: Matcher::RaiseException.new(ZeroDivisionError),
    negate: false
  )
end

raise if actual.actual.class != ZeroDivisionError
raise if actual.error.class != NilClass
raise if actual.got != true

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { 1 / 0 },
    isolation: false,
    matcher: Matcher::RaiseException.new(ZeroDivisionError),
    negate: true
  )
end

raise if actual.actual.class != ZeroDivisionError
raise if actual.error.class != NilClass
raise if actual.got != false

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { 1 / 0 },
    isolation: true,
    matcher: Matcher::BeTheAnswer.new,
    negate: false
  )
end

raise if actual.actual.class != NilClass
raise if actual.error.class != ZeroDivisionError
raise if actual.got != nil

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { 1 / 0 },
    isolation: true,
    matcher: Matcher::BeTheAnswer.new,
    negate: true
  )
end

raise if actual.actual.class != NilClass
raise if actual.error.class != ZeroDivisionError
raise if actual.got != nil

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { 1 / 0 },
    isolation: true,
    matcher: Matcher::RaiseException.new(TypeError),
    negate: false
  )
end

raise if actual.actual.class != NilClass
raise if actual.error.class != ZeroDivisionError
raise if actual.got != nil

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { 1 / 0 },
    isolation: true,
    matcher: Matcher::RaiseException.new(TypeError),
    negate: true
  )
end

raise if actual.actual.class != NilClass
raise if actual.error.class != ZeroDivisionError
raise if actual.got != nil

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { 1 / 0 },
    isolation: true,
    matcher: Matcher::RaiseException.new(ZeroDivisionError),
    negate: false
  )
end

raise if actual.actual.class != ZeroDivisionError
raise if actual.error.class != NilClass
raise if actual.got != true

# ------------------------------------------------------------------------------

actual = begin
  TestTube.content(
    -> { 1 / 0 },
    isolation: true,
    matcher: Matcher::RaiseException.new(ZeroDivisionError),
    negate: true
  )
end

raise if actual.actual.class != ZeroDivisionError
raise if actual.error.class != NilClass
raise if actual.got != false
