# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: ruby_extensions 1.4.0 ruby lib

Gem::Specification.new do |s|
  s.name = "ruby_extensions"
  s.version = "1.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Zachary Powell"]
  s.date = "2014-11-06"
  s.email = "zach@babelian.net"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.md"
  ]
  s.files = [
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.md",
    "Rakefile",
    "VERSION.yml",
    "lib/ruby_extensions.rb",
    "lib/ruby_extensions/hash_extensions.rb",
    "lib/ruby_extensions/nil_class_extensions.rb",
    "lib/ruby_extensions/object_extensions.rb",
    "ruby_extensions.gemspec",
    "shippable.yml",
    "spec/ruby_extensions/hash_extensions_spec.rb",
    "spec/ruby_extensions/nil_class_extensions_spec.rb",
    "spec/ruby_extensions/object_extensions_spec.rb",
    "spec/spec_helper.rb",
    "spec/suite.rb"
  ]
  s.homepage = "http://github.com/babelian/ruby_extensions"
  s.rubygems_version = "2.2.2"
  s.summary = "Extensions for Ruby core classes"

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["= 3.0.0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
    else
      s.add_dependency(%q<rspec>, ["= 3.0.0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
    end
  else
    s.add_dependency(%q<rspec>, ["= 3.0.0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
  end
end

