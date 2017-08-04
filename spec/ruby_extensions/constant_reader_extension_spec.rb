require File.dirname(__FILE__) + '/../spec_helper'

# Class
describe Class do
  # Test class
  class TestConstantReaderParent
    TEST_CONSTANT_1 = 'parent1'.freeze
    TEST_CONSTANT_2 = 'parent2'.freeze
    constant_reader :test_constant_1, :test_constant_2
  end

  class TestConstantReaderChild < TestConstantReaderParent
    TEST_CONSTANT_1 = 'child1'.freeze
  end

  class TestConstantReaderGrandChild < TestConstantReaderChild
    TEST_CONSTANT_2 = 'grandchild2'.freeze
  end

  describe '.constant_reader' do
    it 'parent.constant reads from the same class' do
      expect(TestConstantReaderParent.test_constant_1).to eq('parent1')
      expect(TestConstantReaderParent.test_constant_2).to eq('parent2')
    end

    it 'child.constant overrides if changed' do
      expect(TestConstantReaderChild.test_constant_1).to eq('child1')
    end

    it 'child.constant inherits if unchanged' do
      expect(TestConstantReaderChild.test_constant_2).to eq('parent2')
    end

    it 'parent#constant delegates to class' do
      expect(TestConstantReaderParent.new.test_constant_1).to eq('parent1')
      expect(TestConstantReaderParent.new.test_constant_2).to eq('parent2')
    end

    it 'child#constant delegates to class' do
      expect(TestConstantReaderChild.new.test_constant_1).to eq('child1')
    end

    it 'grand_child.constant overrides if changed' do
      expect(TestConstantReaderGrandChild.new.test_constant_2).to eq('grandchild2')
    end

    it 'grand_child.constant inherits from child if unchanged' do
      expect(TestConstantReaderGrandChild.new.test_constant_1).to eq('child1')
    end
  end
end