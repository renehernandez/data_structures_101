require 'spec_helper'

RSpec.describe DataStructures101::LinkedList do

  let!(:list) { DataStructures101::LinkedList.new }

  let!(:loaded_list) { DataStructures101::LinkedList.new(1, :en, "hello", 5.0) }

  context 'creating a new empty list' do
    it 'is not nil' do
      expect(list).not_to be_nil
    end

    it 'does not raise error' do
      expect {list}.not_to raise_error
    end

    it 'has size 0' do
      expect(list.size).to eql(0)
    end
  end

  context 'creating a list with elements' do
    it 'is not nil' do
      expect(loaded_list).not_to be_nil
    end

    it 'does not raise error' do
      expect {loaded_list}.not_to raise_error
    end

    it "has size 4" do
      expect(loaded_list.size).to eql(4)
    end
  end

  context '#<<' do

    it 'increases size by one' do
      orig_size = loaded_list.size
      loaded_list << 'prueba'
      expect(loaded_list.size).to eql(orig_size + 1)
    end

    it 'returns the same list object' do
      expect(list << 1).to be(list)
    end

  end

  context '#push' do

    it 'increases size by one' do
      orig_size = list.size
      list.push 1
      expect(list.size).to eql(orig_size +1)
    end

    it 'returns the list without change if no elements is passed' do
      expect(list.push).to be(list)
      expect(list.size).to eql(0)
    end

    it 'is the last element' do
      list.push :en
      expect(list.last).to eql(:en)
    end

    it 'returns the same LinkedList object after push' do
      res = list.push 1
      expect(res).to be(list)
    end

    it 'increases size by the number of elements' do
      orig_size = list.size
      list.push(4, 18.5, nil, [], {})
      expect(list.size).to eql(5)
    end

  end

  context '#fetch' do

    it 'returns the first element' do
      expect(loaded_list.fetch(0)).to eql(1)
    end

    it 'fetches the last element if index is -1' do
      expect(loaded_list.fetch(-1)).to eql(5.0)
    end
  end

  context '#last' do

    it 'raises ArgumentError if arg is negative' do
      expect {list.last(-10)}.to raise_error(ArgumentError, "negative array size")
    end

    it 'returns nil if list is empty and no args is passed' do
      expect(list.last).to be_nil
    end

    it 'returns empty LinkedList if list is empty with valid args' do
      result = list.last(3)
      expect(result).to be_a DataStructures101::LinkedList
      expect(result.size).to eql(0)
    end

    it 'returns empty LinkedList if args is 0' do
      result = loaded_list.last(0)
      expect(result).to be_a DataStructures101::LinkedList
      expect(result.size).to eql(0)
    end

    it 'returns 5.0 for the last element' do
      expect(loaded_list.last).to eql(5.0)
    end

    it 'returns a correct LinkedList for last elements' do
      result = loaded_list.last(2)
      expect(result).to be_a DataStructures101::LinkedList
      expect(result.size).to eql(2)
      expect(result.fetch(0)).to eql("hello")
      expect(result.fetch(1)).to eql(5.0)
    end

    it 'returns a LinkedList with the right size for last elements' do
      result = loaded_list.last(5)
      expect(result).to be_a DataStructures101::LinkedList
      expect(result.size).to eql(4)
      expect(result.fetch(0)).to eql(1)
      expect(result.fetch(1)).to eql(:en)
      expect(result.fetch(2)).to eql("hello")
      expect(result.fetch(3)).to eql(5.0)
    end

  end

  context '#first' do

    it 'raises ArgumentError if arg is negative' do
      expect {list.first(-14)}.to raise_error(ArgumentError, "negative array size")
    end

    it 'returns nil if no args and list size is 0' do
      expect(list.first).to be_nil
    end

    it 'returns empty LinkedList if valid args and size is 0' do
      result = list.first(10)
      expect(result).to be_a DataStructures101::LinkedList
      expect(result.size).to eql(0)
    end

    it 'returns empty LinkedList if args is 0' do
      result = loaded_list.first(0)
      expect(result).to be_a DataStructures101::LinkedList
      expect(result.size).to eql(0)
    end

    it 'returns 1 for first value' do
      expect(loaded_list.first).to eql(1)
    end

    it 'returns right LinkedList for last elements' do
      result = loaded_list.first(2)
      expect(result).to be_a DataStructures101::LinkedList
      expect(result.size).to eql(2)
      expect(result.fetch(0)).to eql(1)
      expect(result.fetch(1)).to eql(:en)
    end

    it 'returns LinkedList even if the args is larger than size of the list' do
      result = loaded_list.first(15)
      expect(result).to be_a DataStructures101::LinkedList
      expect(result.size).to eql(4)
      expect(result.fetch(0)).to eql(1)
      expect(result.fetch(1)).to eql(:en)
      expect(result.fetch(2)).to eql('hello')
      expect(result.fetch(3)).to eql(5.0)
    end
  end

  context '#insert' do

    it 'raises IndexError if index is larger than size of bounds' do
      expect {list.insert(10, 'fail')}.to raise_error(IndexError)
    end

    it 'raises IndexError if negative index translate into position less than 0' do
      expect {loaded_list.insert(-5, 'fail')}.to raise_error(IndexError)
    end

    it 'inserts the element at index 1' do
      loaded_list.insert(1, 'hello')
      expect(loaded_list.fetch(1)).to eql('hello')
    end

    it 'inserts several items at position 2' do
      orig_size = loaded_list.size
      loaded_list.insert(2, 'hello', 'world', :ruby)
      expect(loaded_list.size).to eql(orig_size + 3)
      expect(loaded_list.fetch(2)).to eql('hello')
      expect(loaded_list.fetch(3)).to eql('world')
      expect(loaded_list.fetch(4)).to eql(:ruby)
    end

    it 'inserts at last using -1 as index' do
      expect(loaded_list.insert(-1, 'at the end').last).to eql('at the end')
    end

    it 'inserts several elements after position 2 if index is -2' do
      orig_size = loaded_list.size
      loaded_list.insert(-2, 'in', :the, "middle")
      expect(loaded_list.size).to eql(orig_size + 3)
      expect(loaded_list.fetch(3)).to eql('in')
      expect(loaded_list.fetch(4)).to eql(:the)
      expect(loaded_list.fetch(5)).to eql('middle')
    end

  end

  context '#delete' do

    it 'returns nil if no element is present' do
      expect(loaded_list.delete(10)).to be_nil
    end

    it 'returns the same removed value' do
      expect(loaded_list.delete(:en)).to eql(:en)
    end

    it 'removes all the occurrences of the value in the list' do
      loaded_list << :en
      res = loaded_list.delete(:en)

      expect(loaded_list.size).to eql(3)
      expect(res).to eql(:en)
    end
  end

end
