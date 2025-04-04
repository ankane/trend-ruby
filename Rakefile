require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task default: :test

task :benchmark do
  require "benchmark/ips"
  require "trend"

  series = {}
  date = Date.parse("2018-01-01")
  1000.times do
    series[date] = rand(100)
    date += 1
  end

  Trend.url ||= "http://localhost:8000"

  Benchmark.ips do |x|
    x.report("anomalies") { Trend.anomalies(series) }
    x.report("forecast") { Trend.forecast(series) }
  end
end
