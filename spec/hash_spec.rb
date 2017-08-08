require 'spec_helper'

RSpec.describe DataStructures101::ChainHashTable do

    let!(:hash_table) { DataStructures101::ChainHashTable.new }

    context 'creating a new empty list' do
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