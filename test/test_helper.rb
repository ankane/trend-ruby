require "bundler/setup"
Bundler.require(:default)
require "minitest/autorun"

Trend.url ||= "http://localhost:8000"
