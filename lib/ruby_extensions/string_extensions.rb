# Gem Namespace
module RubyExtensions
  # Helpful extensions for {String}
  module StringExtensions
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      # open string in editor and return result
      # @param [String] that you wish to edit
      # @param [String, nil] editor command, defaults to ENV['EDITOR'] or vi
      # @return [String] with changes
      def edit(string = '', editor = nil)
        editor ||= ENV['EDITOR'] || 'vi'

        require 'tempfile'
        f = Tempfile.new 'string-open'
        f.write string
        f.close

        system "#{editor} #{f.path}"

        f.open
        f.read
      ensure
        f.close
        f.unlink
      end
    end
  end
end
