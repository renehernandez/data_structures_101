require 'spec_helper'

RSpec.describe DataStructures101::ChainHashTable do

    let!(:hash_table) { DataStructures101::ChainHashTable.new }

    context 'creating a new empty hash' do
        it 'is not nil' do
            expect(hash_table).not_to be_nil
        end

        it 'does not raise error' do
            expect {hash_table}.not_to raise_error
        end

        it 'has size 0' do
            expect(hash_table.size).to eql(0)
        end
    end

end

RSpec.describe DataStructures101::Hash::Bucket do
    let!(:bucket) { DataStructures101::Hash::Bucket.new }

    let!(:loaded_bucket) do 
        res = DataStructures101::Hash::Bucket.new
        res.insert('test', :test)
        res
    end

    context '#new' do
        it 'is not nil' do
            expect(bucket).not_to be_nil
        end

        it 'does not raise error' do
            expect {bucket}.not_to raise_error
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
            expect(result).to eql(:test)
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
            expect(loaded_bucket.find('test')).to eql(:test)
        end
    end
end