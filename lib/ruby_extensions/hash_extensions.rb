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

    def pretty_inspect
      inspect.gsub(/:([a-z0-9_]*)=>/, '\1: ').gsub('{', '{ ').gsub('}', ' }')
    end

    # http://www.rubydoc.info/github/rubyworks/facets/Hash%3Atraverse
    # modified to not include to_hash logic as you may want the default to_hash
    # of an object.
    def reformat(&block)
      each_with_object({}) do |(k, v), h|
        if v.is_a?(Array)
          v.map! do |s|
            s = yield(nil, s).last
            s = s.reformat(&block) if s.is_a?(Hash)
            s
          end
        end

        v = v.reformat(&block) if v.is_a?(Hash)

        nk, nv = yield(k, v)
        h[nk] = nv

        h
      end
    end
  end
end
