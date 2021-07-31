#!/usr/bin/env ruby
# frozen_string_literal: true

begin
  require "./../helper"
rescue LoadError
  require_relative "./../helper"
end

# ------------------------------------------------------------------------------

actual = begin
  TestTube.pass("101010".to_i(2), matcher: Matcher::BeTheAnswer.new, negate: false)
end

raise if actual.actual != 42
raise if actual.error != nil
raise if actual.got != true
raise if actual.inspect != "<TestTube actual=42 error=nil got=true>"
raise if actual.to_s != "<TestTube actual=42 error=nil got=true>"

# ------------------------------------------------------------------------------

actual = begin
  TestTube.pass("101010".to_i(2), matcher: Matcher::BeTheAnswer.new, negate: true)
end

raise if actual.actual != 42
raise if actual.error != nil
raise if actual.got != false
raise if actual.inspect != "<TestTube actual=42 error=nil got=false>"
raise if actual.to_s != "<TestTube actual=42 error=nil got=false>"

# ------------------------------------------------------------------------------

actual = begin
  TestTube.pass("101010".to_i(2), matcher: Matcher::RaiseException.new(TypeError), negate: false)
end

raise if actual.actual != 42
raise if actual.error != nil
raise if actual.got != false
raise if actual.inspect != "<TestTube actual=42 error=nil got=false>"
raise if actual.to_s != "<TestTube actual=42 error=nil got=false>"

# ------------------------------------------------------------------------------

actual = begin
  TestTube.pass("101010".to_i(2), matcher: Matcher::RaiseException.new(TypeError), negate: true)
end

raise if actual.actual != 42
raise if actual.error != nil
raise if actual.got != true
raise if actual.inspect != "<TestTube actual=42 error=nil got=true>"
raise if actual.to_s != "<TestTube actual=42 error=nil got=true>"

# ------------------------------------------------------------------------------

actual = begin
  TestTube.pass("101010".to_i(2), matcher: Matcher::RaiseException.new(ZeroDivisionError), negate: false)
end

raise if actual.actual != 42
raise if actual.error != nil
raise if actual.got != false
raise if actual.inspect != "<TestTube actual=42 error=nil got=false>"
raise if actual.to_s != "<TestTube actual=42 error=nil got=false>"

# ------------------------------------------------------------------------------

actual = begin
  TestTube.pass("101010".to_i(2), matcher: Matcher::RaiseException.new(ZeroDivisionError), negate: true)
end

raise if actual.actual != 42
raise if actual.error != nil
raise if actual.got != true
raise if actual.inspect != "<TestTube actual=42 error=nil got=true>"
raise if actual.to_s != "<TestTube actual=42 error=nil got=true>"
