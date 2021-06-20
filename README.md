# Test Tube

[![Build Status](https://api.travis-ci.org/fixrb/test_tube.svg?branch=main)](https://travis-ci.org/fixrb/test_tube)
[![Gem Version](https://badge.fury.io/rb/test_tube.svg)](https://rubygems.org/gems/test_tube)
[![Documentation](https://img.shields.io/:yard-docs-38c800.svg)](https://rubydoc.info/gems/test_tube)

> A test tube to conduct software experiments 🧪

![A researcher experimenting with Ruby code](https://github.com/fixrb/test_tube/raw/main/img/social-media-preview.png)

## Installation

Add this line to your application's Gemfile:

```ruby
gem "test_tube"
```

And then execute:

```sh
bundle
```

Or install it yourself as:

```sh
gem install test_tube
```

## Usage

To make __TestTube__ available:

```ruby
require "test_tube"
```

Assuming we'd like to experiment on the answer to the Ultimate Question of Life,
the Universe, and Everything with the following _matcher_:

```ruby
class BeTheAnswer
  def matches?
    42.equal?(yield)
  end
end
```

A _matcher_ is an object that responds to the `matches?` method with a block
parameter representing the _actual value_ to be compared.

Back to our Ruby experiments, one possibility would be to `invoke` a whole block
of code:

```ruby
block_of_code = -> { "101010".to_i(2) }

experiment = TestTube.invoke(
  block_of_code,
  isolation: false,
  matcher:   BeTheAnswer.new,
  negate:    false
)

experiment.actual # => 42
experiment.error  # => nil
experiment.got    # => true
```

An alternative would be to `pass` directly the actual value as a parameter:

```ruby
actual_value = "101010".to_i(2)

experiment = TestTube.pass(
  actual_value,
  matcher: BeTheAnswer.new,
  negate:  false
)

experiment.actual # => 42
experiment.error  # => nil
experiment.got    # => true
```

### __Matchi__ matchers
To facilitate the addition of matchers, a collection is available via the
[__Matchi__ project](https://github.com/fixrb/matchi/).

Let's use a built-in __Matchi__ matcher:

```sh
gem install matchi
```

```ruby
require "matchi"
```

An example of successful experience:

```ruby
experiment = TestTube.invoke(
  -> { "foo".blank? },
  isolation: false,
  matcher:   Matchi::Matcher::RaiseException.new(NoMethodError),
  negate:    false
)

experiment.actual # => #<NoMethodError: undefined method `blank?' for "foo":String>
experiment.error  # => nil
experiment.got    # => true
```

Another example of an experiment that fails:

```ruby
experiment = TestTube.invoke(
  -> { 0.1 + 0.2 },
  isolation: false,
  matcher:   Matchi::Matcher::Equal.new(0.3),
  negate:    false
)

experiment.actual # => 0.30000000000000004
experiment.error  # => nil
experiment.got    # => false
```

Finally, an experiment which causes an error:

```ruby
experiment = TestTube.invoke(
  -> { BOOM },
  isolation: false,
  matcher:   Matchi::Matcher::Match.new(/^foo$/),
  negate:    false
)

experiment.actual # => nil
experiment.error  # => #<NameError: uninitialized constant BOOM>
experiment.got    # => nil
```

### Code isolation

When experimenting tests, side-effects may occur. Because they may or may not be
desired, an `isolation` option is available.

Let's for instance consider this block of code:

```ruby
greeting = "Hello, world!"
block_of_code = -> { greeting.gsub!("world", "Alice") }
```

By setting the `isolation` option to `true`, we can experiment while avoiding
side effects:

```ruby
experiment = TestTube.invoke(
  block_of_code,
  isolation: true,
  matcher:   Matchi::Matcher::Eql.new("Hello, Alice!"),
  negate:    false
)

experiment.inspect # => <TestTube actual="Hello, Alice!" error=nil got=true>

greeting # => "Hello, world!"
```

Otherwise, we can experiment without any code isolation:

```ruby
experiment = TestTube.invoke(
  block_of_code,
  isolation: false,
  matcher:   Matchi::Matcher::Eql.new("Hello, Alice!"),
  negate:    false
)

experiment.inspect # => <TestTube actual="Hello, Alice!" error=nil got=true>

greeting # => "Hello, Alice!"
```

## Contact

* Source code: https://github.com/fixrb/test_tube

## Versioning

__Test Tube__ follows [Semantic Versioning 2.0](https://semver.org/).

## License

The [gem](https://rubygems.org/gems/test_tube) is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

***

<p>
  This project is sponsored by:<br />
  <a href="https://sashite.com/"><img
    src="https://github.com/fixrb/test_tube/raw/main/img/sashite.png"
    alt="Sashite" /></a>
</p>
