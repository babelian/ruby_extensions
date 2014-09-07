if ENV['CODECLIMATE_REPO_TOKEN']
  require "codeclimate-test-reporter"
  CodeClimate::TestReporter.start
elsif ENV['COVERAGE_REPORTS']
  require 'simplecov'
  require 'simplecov-csv'
  SimpleCov.formatter = SimpleCov::Formatter::CSVFormatter
  SimpleCov.coverage_dir(ENV["COVERAGE_REPORTS"])
  SimpleCov.start
elsif ENV['COVERAGE']
  require 'simplecov'
  SimpleCov.start
end

specs_to_run = Dir['./**/*_spec.rb']

specs_to_run.each do |file|
  require file
end