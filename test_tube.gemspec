# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name         = "test_tube"
  spec.version      = File.read("VERSION.semver").chomp
  spec.author       = "Cyril Kato"
  spec.email        = "contact@cyril.email"
  spec.summary      = "A test tube to conduct software experiments 🧪"
  spec.description  = spec.summary
  spec.homepage     = "https://github.com/fixrb/test_tube"
  spec.required_ruby_version = ::Gem::Requirement.new(">= 2.7.0")
  spec.license      = "MIT"
  spec.files        = Dir["LICENSE.md", "README.md", "lib/**/*"]

  spec.add_dependency "defi", "~> 2.0.6"

  spec.add_development_dependency "brutal"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "matchi"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rubocop-md"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "rubocop-rake"
  spec.add_development_dependency "rubocop-thread_safety"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "yard"
end
