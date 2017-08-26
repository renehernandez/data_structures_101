require 'spec_helper'

RSpec.describe DataStructures101::ProbeHashTable do
    let(:hash_table) { DataStructures101::ProbeHashTable.new}

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

        it 'returns nil if key is present' do
            hash_table[:test] = 1
            expect(hash_table[:test]).to eql(1)
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
end