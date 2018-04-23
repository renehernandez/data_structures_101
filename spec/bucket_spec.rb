# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DataStructures101::Hash::Bucket do
  let(:bucket) { DataStructures101::Hash::Bucket.new }
  
  let(:loaded_bucket) do
    res = DataStructures101::Hash::Bucket.new
    res.insert('test', 42)
    res
  end
  
  context '.new' do
    it 'is not nil' do
      expect(bucket).not_to be_nil
    end
    
    it 'does not raise error' do
      expect { bucket }.not_to raise_error
    end
    
    it 'has size 0' do
      expect(bucket.size).to eql(0)
    end
  end
  
  context '#insert' do
    it 'returns nil if key is new' do
      result = bucket.insert(1, '1')
      expect(result).to be_nil
    end
    
    it 'increase size by one if key is new' do
      old_size = bucket.size
      bucket.insert(1, nil)
      expect(bucket.size).to eql(old_size + 1)
    end
    
    it 'returns the previous value if key is present' do
      result = loaded_bucket.insert('test', '')
      expect(result).to eql(42)
    end
    
    it 'keeps the same size if key is present' do
      old_size = loaded_bucket.size
      loaded_bucket.insert('test', '')
      expect(loaded_bucket.size).to eql(old_size)
    end
  end
  
  context '#find' do
    it 'returns nil if key is not present' do
      expect(bucket.find(10)).to be_nil
    end
    
    it 'returns the correct value' do
      expect(loaded_bucket.find('test')).to eql(42)
    end
  end
  
  context '#delete' do
    it 'returns the value of deleted pair' do
      expect(loaded_bucket.delete('test')).to eql(42)
    end
    
    it 'returns nil if key not present' do
      expect(loaded_bucket.delete(:hello)).to be_nil
    end
    
    it 'keeps the same size if key not present' do
      old_size = loaded_bucket.size
      loaded_bucket.delete(40)
      expect(loaded_bucket.size).to eql(old_size)
    end
    
    it 'reduces size by one if key is deleted' do
      old_size = loaded_bucket.size
      loaded_bucket.delete('test')
      expect(loaded_bucket.size).to eql(old_size - 1)
    end
  end
  
  context '#[]' do
    it 'returns the same' do
      expect(loaded_bucket['test']).to eql(loaded_bucket.find('test'))
    end
  end
  
  context '#each' do
    it 'returns enum if no block given' do
      expect(bucket.each).to be_a(Enumerator)
    end
    
    it 'yields args if block given' do
      expect { |b| loaded_bucket.each(&b) }.to yield_control.at_least(1)
    end
  end
end
