require 'simplecov'

if ENV['COVERAGE_REPORTS']
  require 'simplecov-csv'
  SimpleCov.formatter = SimpleCov::Formatter::CSVFormatter
  SimpleCov.coverage_dir(ENV["COVERAGE_REPORTS"])

  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
end

SimpleCov.start

specs_to_run = Dir['./**/*_spec.rb']

specs_to_run.each do |file|
  require file
end