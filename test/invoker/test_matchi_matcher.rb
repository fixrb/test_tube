#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative "../../lib/test_tube/invoker"

require "matchi"

# ------------------------------------------------------------------------------

object = []
actual = TestTube::Invoker.new(matcher: Matchi::Change.new(object, :length).by_at_least(1), negate: false) { object << 1 }

raise if actual.actual != [1]
raise if actual.error != nil
raise if actual.got != true
raise if actual.inspect != "<TestTube actual=[1] error=nil got=true>"
raise if actual.to_s != "<TestTube actual=[1] error=nil got=true>"
