require File.dirname(__FILE__) + '/../spec_helper'

describe Hash do
  describe '#add_class' do
    [
      [{}, nil, {}],
      [{}, 'class1', { class: 'class1' }],
      [{}, 'class1 class2', { class: 'class1 class2' }]
    ].each do |input, string, output|

      it "#{input.inspect}.add_class(#{string.inspect}) => #{output.inspect}" do
        res = input.add_class(string)
        expect(res).to eql(output[:class])
        expect(input).to eql(output)
      end
    end
  end

  describe '#pretty_inspect' do
    [
      [{ a: 'b' }, '{ a: "b" }']
    ].each do |input, output|
      it "#{input.inspect} => #{output}" do
        expect(input.pretty_inspect).to eq(output)
      end
    end
  end

  describe '#reformat' do
    [
      [
        {
          a: {
            b: [
              { c: :d }
            ]
          }
        },
        {
          'a' => {
            'b' => [
              { 'c' => :d }
            ]
          }
        },
        ->(k, v) { [k.is_a?(String) ? k.to_sym : k.to_s, v] }
      ]
    ].each do |input, output, lambda|
      it "#{input.inspect} => #{output.inspect}" do
        expect(input.reformat(&lambda)).to eq(output)
      end
    end
  end
end
