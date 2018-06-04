require 'money'
class Money
  # Range with money objects
  # Implemented because we needed a way of adding up all the possible min..max ranges
  # for an Exclusive to come up with an overall min..max.
  # Note: using first/last methods on the range rather than min/max as (3..2).min = nil!
  class Range < ::Range
    # Range.zero('USD') => "0USD..0USD"
    def self.zero(currency)
      money = Money.new(0, currency)
      new(money, money)
    end

    # This could have also been implemented on Range directly...
    # 0USD..10USD + 5USD..15USD = 5USD..25USD
    def +(other)
      super sanitize_other(other)
    end

    def -(other)
      super sanitize_other(other)
    end

    def inspect
      "#{first}#{currency}..#{last}#{currency}"
    end

    def to_s(format = nil)
      return '' if first.nil? && last.nil?

      if first == last && first.cents > 0
        first.to_s(format == :plus ? :site : format)
      elsif format == :plus
        if first.cents.zero?
          '_free'.t.upcase
        else
          "#{first.to_s(:site)}+"
        end
      else
        "#{first.to_s(format)} - #{last.to_s(format)}"
      end
    end

    def currency
      first.currency
    end

    def min_cents
      first.cents
    end

    def max_cents
      last.cents
    end

    def diff?
      diff_cents.zero? == false
    end

    def diff_cents
      last.cents - first.cents
    end

    def diff
      Money.new(diff_cents, 0)
    end

    def include?(money)
      money >= min && money <= max
    end

    private

    # allows passing cents (eg [0,10]) for the other range
    def sanitize_other(other)
      if other.min.is_a?(Integer)
        [
          Money.new(other.first, currency),
          Money.new(other.last, currency)
        ]
      else
        other
      end
    end

    #
  end
end
