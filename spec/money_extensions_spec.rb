# encoding: utf-8
require 'spec_helper'
require 'money'
require 'money/range'
require 'money_extensions'

describe Money do
  subject { described_class.new(1099, 'GBP') }

  #
  # Fixes
  #

  describe '#-@' do
    it '£10.99 -> -£10.99' do
      expect(-subject.cents).to eq(-subject.cents)
    end
  end

  #
  # Basic Math
  #

  describe '#abs' do
    it '£10.99 -> £10.99' do
      expect(subject.abs.cents).to eq(subject.cents)
    end

    it '-£10.99 -> £10.99' do
      subject = described_class.new(1099)
      subject = -subject
      expect(subject.abs.cents).to eq(1099)
    end
  end

  describe '#round' do
    it '£10.49 -> £10' do
      expect(described_class.new(1049).round.cents).to eq(1000)
    end

    it '£10.50 -> £11' do
      expect(described_class.new(1050).round.cents).to eq(1100)
    end

    it '£10.51 -> £11' do
      expect(described_class.new(1051).round.cents).to eq(1100)
    end
  end

  #
  # Cosmetic Calculations
  #

  describe '#dollars_only' do
    it '$10.00 -> $10' do
      expect(described_class.new(1000).dollars_only.cents).to eq(1000)
    end

    it '$10.99 -> $10' do
      expect(described_class.new(1099).dollars_only.cents).to eq(1000)
    end

    it '-$10.99 -> -$10' do
      subject = described_class.new(1099)
      subject = -subject
      expect(subject.dollars_only.cents).to eq(-1000)
    end
  end

  describe '#cents_only' do
    it '$10.00 -> $0.00' do
      expect(described_class.new(1000).cents_only.cents).to eq(0)
    end

    it '$10.99 -> $0.99' do
      expect(described_class.new(1099).cents_only.cents).to eq(99)
    end

    it '-$10.99 -> -$0.99' do
      subject = described_class.new(1099)
      subject = -subject
      expect(subject.cents_only.cents).to eq(-99)
    end
  end

  describe '#ballpark' do
    it 'of £59.99 by £10 is £50' do
      expect('59.99GBP'.to_money.ballpark('10GBP').to_s).to eq('50.00')
    end

    it 'of £1759.99 by £10 is £1750' do
      expect('1759.99GBP'.to_money.ballpark('10GBP').to_s).to eq('1750.00')
    end

    describe 'of £1750.99' do
      subject { described_class.new(175_099, 'GBP') }

      it 'by £300 is £1500.00' do # default / same as down
        expect(subject.to_money.ballpark('300GBP').to_s).to eq('1500.00')
      end

      it 'by -£300 is £1800.00' do # same as :up
        expect(subject.to_money.ballpark('-300GBP').to_s).to eq('1800.00')
      end

      it 'up by £300 is £1800.00' do
        expect(subject.to_money.ballpark('300GBP', :up).to_s).to eq('1800.00')
      end

      it 'down by £300 is £1500.00' do
        expect(subject.to_money.ballpark('300GBP', :down).to_s).to eq('1500.00')
      end
    end
  end

  #
  # String Formatting
  #

  it '#symbol' do
    expect(subject.symbol).to eq('£')
  end
end

# Test the money_attr method
class TestMoneyAttrClass
  attr_accessor :currency
  attr_accessor :money_cents

  def money_cents!
    101
  end

  money_attr :money, :money!, option: 1
end

describe TestMoneyAttrClass do
  [
    ['blank', '', nil, nil],
    ['invalid', 'abc', nil, nil],
    ['positive no currency', '10.99', 1099, nil],
    ['negative no currency', '-10.99', -1099, nil],
    ['regular', '10.99USD', 1099, 'USD'],
    ['regular with space', ' 10.99 USD ', 1099, 'USD'],
    ['different currency', '5.99GBP', 599, 'GBP'],
    ['ingore negative in the wrong place', '5.99GBP-', 599, 'GBP'],
    ['handles 9.oo', '9.oo', 900, nil]
  ].each do |label, input, cents, currency|
    it "#{label} (#{input.inspect}) => #{cents.inspect}, #{currency.inspect}" do
      subject.money = input
      expect(subject.money_cents).to eq(cents)
      expect(subject.currency).to eq(currency)
    end
  end

  it '#money! methods get added correctly, do not create writer methods' do
    subject.currency = 'EUR'
    expect(subject.money!.cents).to eq(101)
    expect(subject.money!.currency).to eq('EUR')
    expect(subject.respond_to?(:'money!=')).to be false
  end
end