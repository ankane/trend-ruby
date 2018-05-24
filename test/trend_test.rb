require_relative "test_helper"

class TrendTest < Minitest::Test
  def test_anomalies
    series = {}
    date = Date.parse("2018-04-01")
    28.times do
      series[date] = rand(100)
      date += 1
    end
    series[date - 8] = 999

    assert_equal [Date.parse("2018-04-21")], Trend.anomalies(series)
  end

  def test_forecast
    series = {}
    date = Date.parse("2018-04-01")
    28.times do
      series[date] = date.wday
      date += 1
    end

    forecast = Trend.forecast(series, count: 7)
    assert_equal [0, 1, 2, 3, 4, 5, 6], forecast.values
  end
end
