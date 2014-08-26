require File.dirname(__FILE__) + '/../spec_helper'

describe NilClass do

  let(:subject) { nil }

  it "accepts/ignores arguments" do
    expect(subject.to_s('arg')).to eql('')
  end

end