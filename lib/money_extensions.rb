# coding: utf-8
require 'money'

# Extensions to Money
class Money
  CURRENCY_SYMBOLS = {
    'USD' => '$', 'GBP' => '£', 'EUR' => '€', 'AUD' => 'AU$', 'CAD' => 'CA$', 'JPY' => '¥'
  }.freeze

  #
  # Fixes
  #

  def ==(other)
    return false unless other.is_a?(self.class)
    cents == other.cents && bank.same_currency?(currency, other.currency)
  end

  #
  # Basic Math
  #

  # Negative of self
  def -@
    Money.new(-cents, currency)
  end

  # -$15 -> $15
  def abs
    Money.new(cents.abs, currency)
  end

  def round
    Money.new(to_s.to_f.round * 100, currency)
  end

  def ceil
    Money.new(to_s.to_f.ceil * 100, currency)
  end

  def floor
    Money.new(to_s.to_f.floor * 100, currency)
  end

  #
  # Cosmetic Calculations
  #

  # $15.50 -> $15.00 (round)
  # -$15.99 -> -$15
  def dollars_only
    m = abs
    i = m.cents - m.cents % 100
    i = -i if cents < 0
    Money.new(i, currency)
  end

  # $15.50 -> $0.50
  def cents_only
    self - dollars_only
  end

  def has_cents?
    cents_only.cents > 0
  end

  def nonzero?
    !zero?
  end

  #
  # Cosmetic Rounding. Like subtracting the remainder, but cents just get passed across.
  #
  # Usage:
  #
  # "1750.99USD".to_money.ballpark("300USD")      -> "1500USD" (same as :down)
  # "1750.99USD".to_money.ballpark("300USD", :up) -> "1800USD"
  # "1750.99USD".to_money.ballpark("-300USD")     -> "1500USD" (same as :up)
  #
  def ballpark(input = 100, direction = nil)
    figure = figure_to_money(input, direction)

    fail "Must be same currency: #{figure.format} <> #{format}" if figure.currency != currency

    ballpark_cents = dollars_only.cents - (dollars_only.cents % figure.dollars_only.cents)
    ballpark = Money.new(ballpark_cents, currency)
    ballpark += figure.cents_only
    ballpark
  end

  #
  # String Formatting
  #

  def symbol
    CURRENCY_SYMBOLS[currency].to_s
  end

  private

  def figure_to_money(input, direction)
    figure = case input.class.to_s
             when 'Money'
               input
             when 'String'
               input.to_money
             when 'Integer'
               Money.new(input, currency)
             else
               fail "Figure must be money: #{input.inspect}"
             end

    case direction
    when :down
      figure.abs
    when :up
      -figure.abs
    else
      figure
    end
  end
end

# Extensions for Class
class Class
  def money_attr_reader(*args)
    args.reject { |a| a.is_a?(Hash) }.each do |k|
      define_method k do
        cents = if k.to_s.include?('!')
                  send("#{k.to_s[0..-2]}_cents!")
                else
                  send("#{k}_cents")
                end
        Money.new(cents, currency) if cents
      end
    end
  end

  def money_attr_writer(*args)
    opts = args.last.is_a?(Hash) ? args.pop : {}

    unless opts[:validate_currency] == false
      class_eval do
        send(:validates_format_of, :currency, with: /\A[A-Z]{3}\z/, allow_nil: true) if respond_to?(:validates_format_of)
      end
    end

    args.each do |k|
      define_method "#{k}=" do |obj|
        if money = param_to_money(obj)
          send("#{k}_cents=", money.cents.to_i)
          self.currency = money.currency if respond_to?(:currency=)
        else
          send("#{k}_cents=", nil)
        end
        send(k)
      end

      class_eval <<-RB
        if respond_to?(:validates_numericality_of)
          validates_numericality_of("#{k}_cents", :allow_nil => true)
        end
      RB
    end

    define_method :param_to_money do |obj|
      if obj.is_a?(String)
        obj = obj.to_s.upcase

        # no number, blank it out
        obj.gsub!(/^[^\d]*$/,'')

        # only allow '10.99', '10.99USD', '-10.99USD'
        obj.gsub!(/([^\-A-Z0-9\.]*)/, '')

        # cannot end without numbers or alpha (1.99 ok, '1.99USD' ok '1.99-' not ok)
        obj.gsub!(/([^A-Z0-9]*)$/, '')
        obj.gsub!(/\.OO$/, '')

        obj = '' unless obj =~ /\d/

        obj = case obj
              # no digits
              when /^[^\d]*$/
                nil
              # has currency
              when /[A-Z]{3}$/
                obj.to_money
              ## use local currency
              else
                Money.new(obj.to_money.cents, currency)
              end

      elsif obj.is_a?(Hash)
        fail 'Currency required' unless obj[:currency] && obj[:currency] =~ /^[A-Z]{3}$/
        obj = Money.new(obj[:amount], obj[:currency])
      end

      obj
    end
  end

  #
  # money_attr :amount, :total
  #
  # will set validates_currency and validates_numericality_of :amount_cents if methods exist
  def money_attr_accessor(*args)
    money_attr_reader(*args)
    money_attr_writer(*args.reject { |s| s.to_s.include?('!') })
  end

  alias money_attr money_attr_accessor
end
