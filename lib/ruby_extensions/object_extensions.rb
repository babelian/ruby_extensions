#
# Object
#

module RubyExtensions

  module ObjectExtensions

    # View methods unique to object.
    # @param [Regexp] search filter them down
    # @return [Array] of methods
    def filtered_methods(search=nil)
      if self.inspect == self.to_s #hokey way of checking if its a class or an instance
        m = Object.public_methods
      else
        m = Object.new.public_methods
      end

      a = (public_methods - m).sort
      a = a.grep(search) if search
      a
    end

    # console use only
    alias_method :fm, :filtered_methods

    def html_safe
      to_s.html_safe
    end

    # Memoize a method with an instance variable
    # primarily used so that nil is considered "set" to prevent duplicate call issues around "@var ||= method" that repeatedly queries the db returning nil.
    # @param [Symbol,String] key for the memo. If nil is passed the caller method name is used.
    # @param value
    # @param &block
    # @return the block
    def instance_variable_memo(key=nil, value = nil, &block)
      key = (key || (caller.first.scan(/`([^']*)'$/).join(''))).to_s
      key = "@#{key}" unless key[0] == '@'

      if instance_variable_defined?(key)
        instance_variable_get(key)
      else
        value ||= block.call if block_given?
        instance_variable_set(key, value)
      end
    end

    # Opposite of {nil?}
    # @return [Boolean]
    def not_nil?
      !nil?
    end

    # nil if the object is '' or [], otherwise returns {self}
    # @return [self, NilClass]
    def nil_if_empty
      if respond_to?(:empty?) && empty?
        nil
      elsif to_s == ''
        nil
      else
        self
      end
    end

    # Opposite of {blank?}, alias for {present?}
    # @return [Boolean]
    def not_blank?
      present?
    end

    #Opposite of {empty?}
    # @return [Boolean]
    def not_empty?
      !empty?
    end

    # Only call the method if the object responds to it
    # @param [Symbol] method to call
    # @param [Array] args for that method
    def send_if_respond_to(method, *args)
      if self.respond_to?(method)
        self.send(method, *args)
      else
        nil
      end
    end

    # Call a method if it exists, else return nil
    # @example change
    #   something.collection.first.method if something.colletion.first
    #   something.collection.first.send_unless_nil(:method)
    # @param [Symbol] method to call
    # @param [Array] args for that method
    def send_unless_nil(method, *args)
      unless self.nil?
        self.send(method, *args)
      end
    end

    # Send a set of methods
    # @example
    #   something.send_chain('association.method')
    # @param [String] chain the string of methods to chain
    def send_chain(chain)
      chain.to_s.split('.').inject(self) do |proxy, method|
        proxy.send(method)
      end
    end

  end
end