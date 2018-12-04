require File.dirname(__FILE__) + '/../spec_helper'

describe Module do
  describe '.prepend_block' do
    # Test class
    class PrependTest
      def add
        'c'
      end
      prepend_block do
        def add
          'b' + super
        end
      end

      prepend_block do
        def add
          'a' + super
        end
      end
    end

    it 'prepends in the correct order' do
      expect(PrependTest.new.add).to eq('abc')
    end
  end
end
