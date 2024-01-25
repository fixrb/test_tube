# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name                   = "test_tube"
  spec.version                = File.read("VERSION.semver").chomp
  spec.author                 = "Cyril Kato"
  spec.email                  = "contact@cyril.email"
  spec.summary                = "A test tube to conduct software experiments 🧪"
  spec.description            = spec.summary
  spec.homepage               = "https://github.com/fixrb/test_tube"
  spec.license                = "MIT"
  spec.files                  = Dir["LICENSE.md", "README.md", "lib/**/*"]
  spec.required_ruby_version  = ">= 3.2.0"

  spec.metadata["rubygems_mfa_required"] = "true"

  spec.add_dependency "defi", "~> 3.0.0"
end
