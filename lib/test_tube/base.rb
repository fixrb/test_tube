# frozen_string_literal: true

module TestTube
  # The liquid class is great for values.
  class Base
    # @return [#object_id] The actual value.
    attr_reader :actual

    # @return [Exception, nil] The raised exception.
    attr_reader :error

    # @return [Boolean, nil] The test result.
    attr_reader :got
  end
end
