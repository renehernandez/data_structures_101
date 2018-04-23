# frozen_string_literal: true

require 'spec_helper'

RSpec.describe DataStructures101::Heap do
    context '.new' do 
        let(:heap) { DataStructures101::Heap.new }

        it 'is not nil' do
            expect(heap).not_to be_nil
        end

        it 'has size 0' do
            expect(heap.size).to eql(0)
        end
    end

    context 'max heap' do
        let(:heap) do 
            args = 10.times.map { Random.rand(10) }
            DataStructures101::Heap.new(*args) 
        end

        it 'parents are greater or equal than children' do
            1.upto(9) do |i|
                expect(heap[heap.parent(i)]).to be >= heap[i]
            end
        end
    end

    context 'min heap' do
        let(:heap) do 
            args = 10.times.map { Random.rand(10) }
            DataStructures101::Heap.new(*args, min_heap: true) 
        end

        it 'parents are greater or equal than children' do
            1.upto(9) do |i|
                expect(heap[heap.parent(i)]).to be <= heap[i]
            end
        end
    end
end