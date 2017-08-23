require 'spec_helper'

RSpec.describe DataStructures101::ChainedHashTable do

    let!(:hash_table) { DataStructures101::ChainedHashTable.new }

    let!(:loaded_hash) do
        h = DataStructures101::ChainedHashTable.new
        h[4] = 20
        h
    end


    context '.new' do
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

    context '#insert' do
        it 'increases size by one if key not present' do 
            old_size = hash_table.size
            hash_table.insert(1, "1")
            expect(hash_table.size).to eql(old_size + 1)
        end

        it 'returns the previous value if key present' do
            expect(loaded_hash.insert(4, 10)).to eql(20)
        end

        it 'returns the nil if key not present' do
            expect(loaded_hash.insert(20, 10)).to be_nil
        end

        it 'keeps the same size if key is present' do
            old_size = loaded_hash.size
            loaded_hash.insert(4, :t24)
            expect(loaded_hash.size).to eql(old_size)
        end
    end

    context "#[]=" do
        it 'returns the new value as result' do
            expect(loaded_hash[3] = 3).to eql(3)
        end
    end

    context "#[]" do
        it 'returns nil if key not present' do
            expect(hash_table[:hello]).to be_nil
        end

        it 'returns the value if key is present' do
            expect(loaded_hash[4]).to eql(20)
        end
    end
end

RSpec.describe DataStructures101::Hash::Bucket do
    let!(:bucket) { DataStructures101::Hash::Bucket.new }

    let!(:loaded_bucket) do 
        res = DataStructures101::Hash::Bucket.new
        res.insert('test', 42)
        res
    end

    context '.new' do
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

    context '#[] as #find' do
        it 'returns the same' do
            expect(loaded_bucket['test']).to eql(loaded_bucket.find('test'))
        end
    end
end