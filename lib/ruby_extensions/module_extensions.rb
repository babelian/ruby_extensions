module RubyExtensions
  # Module extensions
  module ModuleExtensions
    # wrapper for {prepend} that takes a block instead of a {Module}gs
    def prepend_block(*args, &block)
      if block_given?
        prepend Module.new(&block)
      else
        prepend(*args)
      end
    end
  end
end
