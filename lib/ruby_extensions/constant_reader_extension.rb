module RubyExtensions
  module ConstantReaderExtension
    # creates class and instance reader methods for a constant
    # reads correct constant in sub classes.
    def constant_reader(*syms)
      syms.flatten.each do |sym|
        class_eval <<-RB
          def self.#{sym}
            self::#{sym.to_s.upcase}
          end

          def #{sym}
            self.class.#{sym}
          end
        RB
      end
    end
  end
end
