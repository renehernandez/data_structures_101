require 'spec_helper'

RSpec.describe DataStructures101::ChainedHashTable do

    let(:hash_table) { DataStructures101::ChainedHashTable.new }

    let(:loaded_hash) do
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

        it 'has default capacity 31' do
            expect(hash_table.capacity).to eql(31)
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

    context "#delete" do
        it 'returns nil if key not present' do
            expect(hash_table.delete(10)).to be_nil
        end

        it 'keeps the same size if key not present' do
            old_size = loaded_hash.size
            loaded_hash.delete(:done)
            expect(loaded_hash.size).to eql(old_size)
        end

        it 'returns the value if key present' do
            expect(loaded_hash.delete(4)).to eql(20)
        end

        it 'reduces size by one if key present' do
            old_size = loaded_hash.size
            loaded_hash.delete(4)
            expect(loaded_hash.size).to eql(old_size - 1)
        end
    end

    context "#each" do
        it 'returns enum if no block given' do
            expect(hash_table.each).to be_a(Enumerator)
        end

        it 'yields args if block given' do
            expect { |b| loaded_hash.each(&b) }.to yield_control.at_least(1)
        end
    end

    context "verify resize" do
        let(:twice_hash) do 
            h = DataStructures101::ChainedHashTable.new(5)
            2.times { |i| h[i] = i.to_s }
            h
        end

        it 'resizes to 2*cap - 1' do
            previous_cap = twice_hash.capacity
            twice_hash[3] = '3'
            expect(twice_hash.capacity).to eql(2*previous_cap - 1)
        end

        it 'increase size only by one' do
            previous_size = twice_hash.size
            twice_hash[3] = '3'
            expect(twice_hash.size).to eql(previous_size + 1)
        end
    end
end