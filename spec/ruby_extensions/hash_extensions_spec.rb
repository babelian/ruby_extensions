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

end
