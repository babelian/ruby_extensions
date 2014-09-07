source 'https://rubygems.org'
group :development, :test do
  gem 'rspec', '3.0.0'
  gem 'jeweler'
end

group :test do
  if ENV['SHIPPABLE']
    gem "ci_reporter"
    gem "codeclimate-test-reporter"
    gem 'minitest-reporters'
    gem "rspec_junit_formatter"
    gem 'simplecov-csv'
  end
end