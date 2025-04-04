require "bundler/setup"
Bundler.require(:default)
require "minitest/autorun"
require "minitest/pride"

Trend.url ||= "http://localhost:8000"
