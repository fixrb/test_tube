# Test Tube

[![Version](https://img.shields.io/github/v/tag/fixrb/test_tube?label=Version&logo=github)](https://github.com/fixrb/test_tube/tags)
[![Yard documentation](https://img.shields.io/badge/Yard-documentation-blue.svg?logo=github)](https://rubydoc.info/github/fixrb/test_tube/main)
[![Ruby](https://github.com/fixrb/test_tube/workflows/Ruby/badge.svg?branch=main)](https://github.com/fixrb/test_tube/actions?query=workflow%3Aruby+branch%3Amain)
[![RuboCop](https://github.com/fixrb/test_tube/workflows/RuboCop/badge.svg?branch=main)](https://github.com/fixrb/test_tube/actions?query=workflow%3Arubocop+branch%3Amain)
[![License](https://img.shields.io/github/license/fixrb/test_tube?label=License&logo=github)](https://github.com/fixrb/test_tube/raw/main/LICENSE.md)

> A test tube to conduct software experiments 🧪

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

To make __TestTube__ available:

```ruby
require "test_tube"
```

Assuming we'd like to experiment on the answer to the Ultimate Question of Life,
the Universe, and Everything with the following matcher:

```ruby
class BeTheAnswer
  def match?
    42.equal?(yield)
  end
end
```

One possibility would be to `invoke` a whole block of code:

```ruby
block_of_code = -> { "101010".to_i(2) }

experiment = TestTube.invoke(matcher: BeTheAnswer.new, negate: false, &block_of_code)
# => <TestTube actual=42 error=nil got=true>

experiment.actual # => 42
experiment.error  # => nil
experiment.got    # => true
```

An alternative would be to `pass` directly the actual value as a parameter:

```ruby
actual_value = "101010".to_i(2)

experiment = TestTube.pass(actual_value, matcher: BeTheAnswer.new, negate: false)
# => <TestTube actual=42 error=nil got=true>

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
  matcher: Matchi::RaiseException.new(:NoMethodError),
  negate:  false
) { "foo".blank? }
# => <TestTube actual=#<NoMethodError: undefined method `blank?' for "foo":String> error=nil got=true>

experiment.actual # => #<NoMethodError: undefined method `blank?' for "foo":String>
experiment.error  # => nil
experiment.got    # => true
```

Another example of an experiment that fails:

```ruby
experiment = TestTube.invoke(
  matcher: Matchi::Be.new(0.3),
  negate:  false,
  &-> { 0.1 + 0.2 }
) # => <TestTube actual=0.30000000000000004 error=nil got=false>

experiment.actual # => 0.30000000000000004
experiment.error  # => nil
experiment.got    # => false
```

Finally, an experiment which causes an error:

```ruby
experiment = TestTube.invoke(
  matcher: Matchi::Match.new(/^foo$/),
  negate:  false
) { BOOM }
# => <TestTube actual=nil error=#<NameError: uninitialized constant BOOM> got=nil>

experiment.actual # => nil
experiment.error  # => #<NameError: uninitialized constant BOOM>
experiment.got    # => nil
```

## Contact

* Source code: https://github.com/fixrb/test_tube
* Chinese blog post: https://ruby-china.org/topics/41390
* Japanese blog post: https://qiita.com/cyril/items/36174b619ff1852c80ec

## Versioning

__Test Tube__ follows [Semantic Versioning 2.0](https://semver.org/).

## License

The [gem](https://rubygems.org/gems/test_tube) is available as open source under the terms of the [MIT License](https://github.com/fixrb/test_tube/raw/main/LICENSE.md).

---

<p>
  This project is sponsored by:<br />
  <a href="https://sashite.com/"><img
    src="https://github.com/fixrb/test_tube/raw/main/img/sashite.png"
    alt="Sashité" /></a>
</p>
