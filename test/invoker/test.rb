#!/usr/bin/env ruby
# frozen_string_literal: true

begin
  require "./../helper"
rescue LoadError
  require_relative "./../helper"
end

# ------------------------------------------------------------------------------

actual = begin
  TestTube.invoke(matcher: Matcher::BeTheAnswer.new, negate: false,
    &-> { "101010".to_i(2) }
  )
end

raise if actual.actual.class != Integer
raise if actual.error.class != NilClass
raise if actual.got != true
raise if actual.inspect != "<TestTube actual=42 error=nil got=true>"
raise if actual.to_s != "<TestTube actual=42 error=nil got=true>"

# ------------------------------------------------------------------------------

actual = begin
  TestTube.invoke(matcher: Matcher::BeTheAnswer.new, negate: true,
    &-> { "101010".to_i(2) }
  )
end

raise if actual.actual.class != Integer
raise if actual.error.class != NilClass
raise if actual.got != false
raise if actual.inspect != "<TestTube actual=42 error=nil got=false>"
raise if actual.to_s != "<TestTube actual=42 error=nil got=false>"

# ------------------------------------------------------------------------------

actual = begin
  TestTube.invoke(matcher: Matcher::RaiseException.new(TypeError), negate: false,
    &-> { "101010".to_i(2) }
  )
end

raise if actual.actual.class != Integer
raise if actual.error.class != NilClass
raise if actual.got != false
raise if actual.inspect != "<TestTube actual=42 error=nil got=false>"
raise if actual.to_s != "<TestTube actual=42 error=nil got=false>"

# ------------------------------------------------------------------------------

actual = begin
  TestTube.invoke(matcher: Matcher::RaiseException.new(TypeError), negate: true,
    &-> { "101010".to_i(2) }
  )
end

raise if actual.actual.class != Integer
raise if actual.error.class != NilClass
raise if actual.got != true
raise if actual.inspect != "<TestTube actual=42 error=nil got=true>"
raise if actual.to_s != "<TestTube actual=42 error=nil got=true>"

# ------------------------------------------------------------------------------

actual = begin
  TestTube.invoke(matcher: Matcher::RaiseException.new(ZeroDivisionError), negate: false,
    &-> { "101010".to_i(2) }
  )
end

raise if actual.actual.class != Integer
raise if actual.error.class != NilClass
raise if actual.got != false
raise if actual.inspect != "<TestTube actual=42 error=nil got=false>"
raise if actual.to_s != "<TestTube actual=42 error=nil got=false>"

# ------------------------------------------------------------------------------

actual = begin
  TestTube.invoke(matcher: Matcher::RaiseException.new(ZeroDivisionError), negate: true,
    &-> { "101010".to_i(2) }
  )
end

raise if actual.actual.class != Integer
raise if actual.error.class != NilClass
raise if actual.got != true
raise if actual.inspect != "<TestTube actual=42 error=nil got=true>"
raise if actual.to_s != "<TestTube actual=42 error=nil got=true>"

# ------------------------------------------------------------------------------

actual = begin
  TestTube.invoke(matcher: Matcher::BeTheAnswer.new, negate: false,
    &-> { 1 / 0 }
  )
end

raise if actual.actual.class != NilClass
raise if actual.error.class != ZeroDivisionError
raise if actual.got != nil
raise if actual.inspect != "<TestTube actual=nil error=#<ZeroDivisionError: divided by 0> got=nil>"
raise if actual.to_s != "<TestTube actual=nil error=#<ZeroDivisionError: divided by 0> got=nil>"

# ------------------------------------------------------------------------------

actual = begin
  TestTube.invoke(matcher: Matcher::BeTheAnswer.new, negate: true,
    &-> { 1 / 0 }
  )
end

raise if actual.actual.class != NilClass
raise if actual.error.class != ZeroDivisionError
raise if actual.got != nil
raise if actual.inspect != "<TestTube actual=nil error=#<ZeroDivisionError: divided by 0> got=nil>"
raise if actual.to_s != "<TestTube actual=nil error=#<ZeroDivisionError: divided by 0> got=nil>"

# ------------------------------------------------------------------------------

actual = begin
  TestTube.invoke(matcher: Matcher::RaiseException.new(TypeError), negate: false,
    &-> { 1 / 0 }
  )
end

raise if actual.actual.class != NilClass
raise if actual.error.class != ZeroDivisionError
raise if actual.got != nil
raise if actual.inspect != "<TestTube actual=nil error=#<ZeroDivisionError: divided by 0> got=nil>"
raise if actual.to_s != "<TestTube actual=nil error=#<ZeroDivisionError: divided by 0> got=nil>"

# ------------------------------------------------------------------------------

actual = begin
  TestTube.invoke(matcher: Matcher::RaiseException.new(TypeError), negate: true,
    &-> { 1 / 0 }
  )
end

raise if actual.actual.class != NilClass
raise if actual.error.class != ZeroDivisionError
raise if actual.got != nil
raise if actual.inspect != "<TestTube actual=nil error=#<ZeroDivisionError: divided by 0> got=nil>"
raise if actual.to_s != "<TestTube actual=nil error=#<ZeroDivisionError: divided by 0> got=nil>"

# ------------------------------------------------------------------------------

actual = begin
  TestTube.invoke(matcher: Matcher::RaiseException.new(ZeroDivisionError), negate: false,
    &-> { 1 / 0 }
  )
end

raise if actual.actual.class != ZeroDivisionError
raise if actual.error.class != NilClass
raise if actual.got != true
raise if actual.inspect != "<TestTube actual=#<ZeroDivisionError: divided by 0> error=nil got=true>"
raise if actual.to_s != "<TestTube actual=#<ZeroDivisionError: divided by 0> error=nil got=true>"

# ------------------------------------------------------------------------------

actual = begin
  TestTube.invoke(matcher: Matcher::RaiseException.new(ZeroDivisionError), negate: true,
    &-> { 1 / 0 }
  )
end

raise if actual.actual.class != ZeroDivisionError
raise if actual.error.class != NilClass
raise if actual.got != false
raise if actual.inspect != "<TestTube actual=#<ZeroDivisionError: divided by 0> error=nil got=false>"
raise if actual.to_s != "<TestTube actual=#<ZeroDivisionError: divided by 0> error=nil got=false>"
