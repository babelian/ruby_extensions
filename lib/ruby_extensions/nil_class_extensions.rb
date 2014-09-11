#
# NilClass
#
# does not work by module include so we're patching it directly
class NilClass

  # Add params to nil.to_s so that if you call Rail's style strings on nil they won't error
  # @example
  #   updated_at.to_s(:db) => nil
  # @param args to be ignored
  # @return [String] that is blank
  def to_s(*args)
    ''
  end

end