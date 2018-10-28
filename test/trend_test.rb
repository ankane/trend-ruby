require_relative "test_helper"

class TrendTest < Minitest::Test
  def test_anomalies
    series = {}
    date = Date.parse("2018-04-01")
    28.times do
      series[date] = rand(100)
      date += 1
    end
    series[date - 13] = nil # test nil
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
    series.delete(date - 13) # test missing

    forecast = Trend.forecast(series, count: 7)
    assert_equal [0, 1, 2, 3, 4, 5, 6], forecast.values
  end

  def test_correlation
    series = {}
    date = Date.parse("2018-04-01")
    28.times do
      series[date] = date.wday
      date += 1
    end

    series2 = series.dup
    series2[date - 8] = 10

    correlation = Trend.correlation(series, series2)
    assert_equal 0.9522, correlation
  end

  def test_correlation_exact
    series = {}
    date = Date.parse("2018-04-01")
    28.times do
      series[date] = date.wday
      date += 1
    end

    # test positive
    correlation = Trend.correlation(series, series)
    assert_equal 1, correlation

    # test negative
    correlation = Trend.correlation(series, Hash[series.map { |k, v| [k, -v] }])
    assert_equal(-1, correlation)
  end
end
