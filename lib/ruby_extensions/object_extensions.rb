#
# Object
#

module RubyExtensions

  module ObjectExtensions

    # View methods unique to object.
    # @param [Regexp] search filter them down
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

    def not_nil?
      !nil?
    end

    # like blank? but doesn't return true if FalseClass
    # do not use unless the param could plausibly be FalseClass
    def nil_or_empty?
      if respond_to?('empty?')
        empty?
      else
        nil?
      end
    end

    def nil_if_empty
      to_s == '' ? nil : self
    end

    def not_blank?
      !blank?
    end

    def not_empty?
      !empty?
    end

    # Call a method if the
    # @param [Symbol] method to call
    # @param [Array] args for that method
    def send_if_respond_to(method, *args)
      if self.respond_to?(method)
        self.send(method, *args)
      else
        nil
      end
    end

    # change:
    # something.collection.first.method if something.colletion.first
    # to
    # something.collection.first.send_unless_nil(:method)
    #
    # @param [Symbol] method to call
    # @param [Array] args for that method
    def send_unless_nil(method, *args)
      unless self.nil?
        self.send(method, *args)
      end
    end

    # Send a set of methods
    # something.send_chain('association.method')
    def send_chain(chain)
      chain.to_s.split('.').inject(self) do |proxy, method|
        proxy.send(method)
      end
    end

  end
end