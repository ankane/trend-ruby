require_relative "lib/trend/version"

Gem::Specification.new do |spec|
  spec.name          = "trend"
  spec.version       = Trend::VERSION
  spec.summary       = "Ruby client for Trend, the time series API"
  spec.homepage      = "https://github.com/ankane/trend-ruby"
  spec.license       = "MIT"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@ankane.org"

  spec.files         = Dir["*.{md,txt}", "{lib}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 3"
end
