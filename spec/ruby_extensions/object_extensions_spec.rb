require File.dirname(__FILE__) + '/../spec_helper'

describe Object do

  describe "#filtered_methods" do

    let(:subject) { "string".filtered_methods }

    context "on the Array class" do

      let(:subject) { Array.filtered_methods }

      it "includes Array class methods" do
        is_expected.to include(:[])
      end

      it "does not include Object class methods" do
        is_expected.to_not include(:superclass)
      end

    end

    context "on a String instance" do

      let(:subject) { "string".filtered_methods }

      it "includes String methods" do
        is_expected.to include(:strip)
      end

      it "does not include Object instance methods" do
        is_expected.to_not include(:object_id)
      end
    end


    it "sorts" do
      is_expected.to eql subject.sort
    end

    it "filters via regexp" do
      "string".filtered_methods(/^s/).each do |method|
        expect(method).to_s =~ /^s/
      end
    end

  end

  it "#html_safe"

  describe "#instance_variable_memo" do

    let(:subject) { described_class.new }

    context "getting" do

      it "with a value" do
        subject.instance_variable_set('@key', 'value')
        expect(subject).to receive(:instance_variable_set).never
        expect(subject.instance_variable_memo(:key)).to eql('value')
      end

      it "with a value of nil" do
        subject.instance_variable_set('@key', nil)
        expect(subject).to receive(:instance_variable_set).never
        expect(subject.instance_variable_memo(:key)).to eql(nil)
      end

    end

    context "setting" do

      it "by variable" do
        expect(subject.instance_variable_memo(:key, 'value')).to eql('value')
      end

      it "can set nil" do
        expect(subject.instance_variable_memo(:key)).to eql(nil)
      end

      it "by block" do
        s = subject.instance_variable_memo(:key) { 'value' }
        expect(s).to eql('value')
        expect(subject.instance_variable_get('@key')).to eql('value')
      end

      it "perfers value" do
        s = subject.instance_variable_memo(:key,'value1') { 'value2' }
        expect(s).to eql('value1')

        expect(subject.instance_variable_get('@key')).to eql('value1')
      end

    end

  end

  it "#not_nil?"

  it "#nil_or_empty?"

  it "#nil_if_empty"

  it "#not_blank?"

  it "#not_empty?"

  describe "#send_if_respond_to" do

    it "sends if object responds to method" do
      expect(subject.send_if_respond_to(:inspect)).to be_a(String)
    end

    it "is nil if method does not exist" do
      expect(subject.send_if_respond_to(:blah)).to be_nil
    end

  end

  describe "#send_unless_nil" do

    it "does not send when nil" do
      subject = nil
      expect(subject).to receive(:inspect).never
      subject.send_unless_nil(:inspect)
    end

    it "sends when object exists" do
      expect(subject).to receive(:inspect).and_return ("ok")
      expect(subject.send_unless_nil(:inspect)).to eql("ok")
    end

  end

  it "#send_chain" do
    expect([1,2,3].send_chain("join.to_i")).to eql(123)
  end

end
