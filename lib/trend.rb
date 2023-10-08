# stdlib
require "date"
require "json"
require "net/http"
require "time"

# modules
require_relative "trend/client"
require_relative "trend/version"

module Trend
  class Error < StandardError; end

  def self.anomalies(*args)
    client.anomalies(*args)
  end

  def self.forecast(*args)
    client.forecast(*args)
  end

  def self.correlation(*args)
    client.correlation(*args)
  end

  def self.url
    @url ||= ENV["TREND_URL"] || hosted_url
  end

  def self.url=(url)
    @url = url
    @client = nil
  end

  def self.api_key
    @api_key ||= ENV["TREND_API_KEY"]
  end

  def self.api_key=(api_key)
    @api_key = api_key
    @client = nil
  end

  # private
  def self.client
    @client ||= Client.new
  end

  # private
  def self.hosted_url
    warn "[trend] WARNING: The hosted version is shutting down on May 1, 2024. See https://github.com/ankane/trend-api for how to run the API on your own infrastructure."
    "https://trendapi.org"
  end
end
