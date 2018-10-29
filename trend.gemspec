
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "trend/version"

Gem::Specification.new do |spec|
  spec.name          = "trend"
  spec.version       = Trend::VERSION
  spec.summary       = "Ruby client for Trend, the time series API"
  spec.homepage      = "https://github.com/ankane/trend"
  spec.license       = "MIT"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@chartkick.com"

  spec.files         = Dir["*.{md,txt}", "{lib}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 2.2"

  spec.add_development_dependency "benchmark-ips"
  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
end
