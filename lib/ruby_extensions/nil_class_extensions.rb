#
# NilClass
#
# does not work by module include so we're patching it directly

class NilClass

  # Add params to nil.to_s so that Rails style something.updated_at.to_s(:db) does not fail if the timestamp is nil
  def to_s(*args)
    ''
  end

end