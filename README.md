# Test Tube

[![Version](https://img.shields.io/github/v/tag/fixrb/test_tube?label=Version&logo=github)](https://github.com/fixrb/test_tube/tags)
[![Yard documentation](https://img.shields.io/badge/Yard-documentation-blue.svg?logo=github)](https://rubydoc.info/github/fixrb/test_tube/main)
[![License](https://img.shields.io/github/license/fixrb/test_tube?label=License&logo=github)](https://github.com/fixrb/test_tube/raw/main/LICENSE.md)

> A test tube to conduct software experiments safely 🧪

TestTube is a Ruby library designed to safely execute and evaluate code experiments. It provides:
- Complete exception handling (including SystemExit and other system-level exceptions)
- A flexible matcher-based testing approach
- Two distinct testing methods: code execution (`invoke`) and value testing (`pass`)
- Clear experiment results with actual values, errors, and matcher results

![A researcher experimenting with Ruby code](https://github.com/fixrb/test_tube/raw/main/img/social-media-preview.png)

## Installation

Add this line to your application's Gemfile:

```ruby
gem "test_tube"
```

And then execute:

```sh
bundle install
```

Or install it yourself as:

```sh
gem install test_tube
```

## Usage

### Basic Usage

First, make TestTube available:

```ruby
require "test_tube"
```

TestTube provides two main ways to conduct experiments:

1. **Execute and test code** with `invoke`:
   - Safely executes blocks of code
   - Catches ALL exceptions, including system-level ones
   - Perfect for testing potentially dangerous operations

2. **Test direct values** with `pass`:
   - Tests pre-computed values
   - Simpler and more direct approach
   - Ideal when you already have the value to test

### Simple Example

Let's test if a value equals 42 using a custom matcher:

```ruby
class BeTheAnswer
  def match?
    42.equal?(yield)
  end
end

# Using invoke to execute code
experiment = TestTube.invoke(matcher: BeTheAnswer.new, negate: false) do
  "101010".to_i(2) # Converting binary to decimal
end
experiment.got    # => true
experiment.actual # => 42
experiment.error  # => nil

# Or using pass with a direct value
experiment = TestTube.pass(42, matcher: BeTheAnswer.new, negate: false)
experiment.got    # => true
experiment.actual # => 42
experiment.error  # => nil
```

### Integration with Matchi

TestTube works seamlessly with the [Matchi](https://github.com/fixrb/matchi/) matcher library:

```sh
gem install matchi
```

```ruby
require "matchi"

# Testing for exceptions
experiment = TestTube.invoke(
  matcher: Matchi::RaiseException.new(:NoMethodError),
  negate:  false
) { "foo".blank? }
experiment.got    # => true
experiment.actual # => #<NoMethodError: undefined method `blank?' for "foo":String>

# Testing floating-point arithmetic
experiment = TestTube.invoke(
  matcher: Matchi::Be.new(0.3),
  negate:  false
) { 0.1 + 0.2 }
experiment.got    # => false
experiment.actual # => 0.30000000000000004

# Handling errors gracefully
experiment = TestTube.invoke(
  matcher: Matchi::Match.new(/^foo$/),
  negate:  false
) { BOOM }
experiment.got    # => nil
experiment.error  # => #<NameError: uninitialized constant BOOM>
experiment.actual # => nil
```

## Key Features

- **Safe Execution**: Catches all exceptions, including system-level ones
- **Flexible Testing**: Support for custom matchers and the Matchi library
- **Clear Results**: Easy access to actual values, errors, and test results
- **Two Testing Modes**: Choose between code execution and direct value testing
- **Framework Friendly**: Perfect for building testing frameworks and tools

## Contact

* Source code: https://github.com/fixrb/test_tube
* Chinese blog post: https://ruby-china.org/topics/41390
* Japanese blog post: https://qiita.com/cyril/items/36174b619ff1852c80ec

## Versioning

Test Tube follows [Semantic Versioning 2.0](https://semver.org/).

## License

The [gem](https://rubygems.org/gems/test_tube) is available as open source under the terms of the [MIT License](https://github.com/fixrb/test_tube/raw/main/LICENSE.md).

## Sponsors

This project is sponsored by [Sashité](https://sashite.com/)
