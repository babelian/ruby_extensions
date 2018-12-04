require 'ruby_extensions/constant_reader_extension'
require 'ruby_extensions/module_extensions'
require 'ruby_extensions/object_extensions'
require 'ruby_extensions/hash_extensions'
require 'ruby_extensions/nil_class_extensions'
require 'ruby_extensions/rails_environment_extensions'

# @private
class Class
  include RubyExtensions::ConstantReaderExtension
end

# @private
Module.include(RubyExtensions::ModuleExtensions)

# @private
class Object
  include RubyExtensions::ObjectExtensions
end

# @private
class Hash
  include RubyExtensions::HashExtensions
end

include RubyExtensions::RailsEnvironmentExtensions # rubocop:disable all
