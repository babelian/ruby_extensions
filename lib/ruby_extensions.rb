require 'ruby_extensions/object_extensions'
require 'ruby_extensions/hash_extensions'
require 'ruby_extensions/nil_class_extensions'

# @private
class Object
  include RubyExtensions::ObjectExtensions
end

# @private
class Hash
  include RubyExtensions::HashExtensions
end
