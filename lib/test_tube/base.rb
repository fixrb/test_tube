# frozen_string_literal: true

module TestTube
  # Abstract class representing the state of an experiment.
  #
  # @api private
  class Base
    # Expectation's actual value.
    #
    # @return [#object_id] The actual value.
    #
    # @api public
    attr_reader :actual

    # Expectation's raised error.
    #
    # @return [Exception, nil] The raised error.
    #
    # @api public
    attr_reader :error

    # Expectation's returned boolean value.
    #
    # @return [Boolean, nil] The returned boolean value.
    #
    # @api public
    attr_reader :got

    # A string containing a human-readable representation of the experiment.
    #
    # @return [String] The human-readable representation of the experiment.
    #
    # @api public
    def inspect
      "<TestTube actual=#{actual.inspect} error=#{error.inspect} got=#{got.inspect}>"
    end

    alias to_s inspect
  end
end
