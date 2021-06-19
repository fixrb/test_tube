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

Assuming we'd like to experiment on the answer to the Ultimate Question of Life,
the Universe, and Everything with the following matcher:

```ruby
class BeTheAnswer
  def matches?
    42.equal?(yield)
  end
end
```

One possibility would be to challenge a whole block of code:

```ruby
tt = TestTube.invoke(
  -> { "101010".to_i(2) },
  isolation: false,
  matcher:   BeTheAnswer.new,
  negate:    false
)
# => #<TestTube::Content:0x00007fb3b328b248 @actual=42, @got=true, @error=nil>

tt.actual # => 42
tt.error  # => nil
tt.got    # => true
```

An alternative would be to challenge a value passed as a parameter:

```ruby
tt = TestTube.pass(
  "101010".to_i(2),
  matcher: BeTheAnswer.new,
  negate:  false
)
# => #<TestTube::Passer:0x00007f85c229c2d8 @actual=42, @got=true>

tt.actual # => 42
tt.error  # => nil
tt.got    # => true
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
