require File.dirname(__FILE__) + '/../spec_helper'

describe Object do

  # Fake Rails
  class Rails
    def self.env
      'development'
    end

    def self.call
      'response'
    end
  end

  describe '#in_environment' do

    it 'with a string' do
      expect(in_environment('development')).to eql(true)
    end

    it 'with regexp' do
      expect(in_environment(/^dev/)).to eql(true)
      expect(in_environment(/^test/)).to eql(false)
    end

    it 'with a block' do
      res = in_environment('development') { Rails.call }
      expect(res).to eql(Rails.call)
      res = in_environment('test') { Rails.call }
      expect(res).to be_nil
    end
  end

  it '#in_development' do
    expect(in_development).to eql(true)
  end

  it '#in_testing' do
    expect(in_testing).to eql(false)
  end
end
