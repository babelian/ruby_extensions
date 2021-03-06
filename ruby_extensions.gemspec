require './lib/ruby_extensions/version'

Gem::Specification.new do |s|
  s.name = 'ruby_extensions'
  s.version = RubyExtensions::VERSION

  s.authors = 'Zachary Powell'
  s.email = 'zach@babelian.net'
  s.homepage = 'http://github.com/babelian/ruby_extensions'
  s.license = 'MIT'
  s.summary = 'Extensions for core Ruby classes'

  s.files = Dir.glob('{lib}/**/*')
  s.extra_rdoc_files = ['LICENSE', 'README.md']
  s.require_paths = %w[lib]
  s.required_ruby_version = '>= 2.5.3'
  s.rubygems_version = '3.0.1'

  s.add_development_dependency 'rake', '12.3.2'
  s.add_development_dependency 'rspec', '3.8.0'
  s.add_development_dependency 'simplecov', '0.16.1'
end
