# Gem Namespace
module RubyExtensions
  # Helpful extensions for {Hash}
  module HashExtensions
    # For adding a css class
    # @example
    #   {}.add_class('bold') => {:class => 'bold'}
    #   {:class => "bold"}.add_class('bold') => {:class => 'bold'}
    #   {:class => "bold"}.add_class('italic') => {:class => 'italic bold'}
    # @param [String] additional classes
    # @retun [String] new classes
    def add_class(additions)
      return unless additions
      self[:class] = [self[:class], additions].compact.join(' ')
    end
  end
end
