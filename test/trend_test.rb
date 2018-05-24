require_relative "test_helper"

class TrendTest < Minitest::Test
  def test_dates
    series = {}
    date = Date.parse("2018-01-01")
    28.times do
      series[date] = date.wday
      date += 1
    end
    series[date - 1] = 2
    # p date - 1
    # p series

    puts Trend.anomalies(series).to_json
    puts Trend.forecast(series).to_json
    puts Trend.forecast(series, count: 1).to_json
  end

  def test_times
    series = {}
    time = Time.parse("2018-01-01")
    48.times do
      series[time] = rand
      time += 3600
    end
    series[time - 3600] = 10
    # p date - 1
    # p series

    p Trend.anomalies(series)
    p Trend.forecast(series, count: 3)
  end

  def test_forecast
    series = {}
    start_date = Date.parse("2018-01-01")
    30.times do |i|
      series[start_date + i] = i + rand
    end

    puts Trend.forecast(series).to_json
  end
end
