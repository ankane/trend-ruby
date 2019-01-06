require "trend/version"

module Trend
  class Client
    HEADERS = {
      "Content-Type" => "application/json",
      "Accept" => "application/json",
      "User-Agent" => "trend-ruby/#{Trend::VERSION}"
    }

    def initialize(url: nil, api_key: nil)
      @api_key = api_key || Trend.api_key
      @uri = URI.parse(url || Trend.url)
      @http = Net::HTTP.new(@uri.host, @uri.port)
      @http.use_ssl = true if @uri.scheme == "https"
      @http.open_timeout = 3
      @http.read_timeout = 12
    end

    def anomalies(series, params = {})
      resp = make_request("anomalies", series, params)
      resp["anomalies"].map { |v| parse_time(v) }
    end

    def forecast(series, params = {})
      resp = make_request("forecast", series, params)
      Hash[resp["forecast"].map { |k, v| [parse_time(k), v] }]
    end

    def correlation(series, series2, params = {})
      resp = make_request("correlation", series, params.merge(series2: series2))
      resp["correlation"]
    end

    private

    def make_request(path, series, params)
      post_data = {
        series: series
      }.merge(params)

      path = "#{path}?#{URI.encode_www_form(api_key: @api_key)}" if @api_key

      begin
        response = @http.post("/#{path}", post_data.to_json, HEADERS)
      rescue Errno::ECONNREFUSED, Timeout::Error => e
        raise Trend::Error, e.message
      end

      parsed_body = JSON.parse(response.body) rescue {}

      if !response.is_a?(Net::HTTPSuccess)
        raise Trend::Error, parsed_body["error"] || "Server returned #{response.code} response"
      end

      parsed_body
    end

    def parse_time(v)
      v.size == 10 ? Date.parse(v) : Time.parse(v)
    end
  end
end
