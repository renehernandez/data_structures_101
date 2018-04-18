# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DataStructures101::Heap do
    let(:heap) { DataStructures101::Heap.new }


    context '.new' do 
        it 'is not nil' do
            expect(heap).not_to be_nil
        end

        it 'has size 0' do
            expect(heap.size).to eql(0)
        end
    end
end