require File.dirname(__FILE__) + '/../spec_helper'

describe String do
  describe '.edit' do
    it 'creates a temp file from string, opens editor, and returns saved contents' do
      # usually editor would be nano or vi etc but in tests we need something that doesn't block.
      editor = "sed -i -e 's/abc/XYZ/g'"
      res = described_class.edit('abc', editor).strip
      expect(res).to eq('XYZ')
    end
  end
end
