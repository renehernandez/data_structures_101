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

    context 'merge' do 
        let(:max_heap) do 
            args = 10.times.map { Random.rand(10) }
            DataStructures101::Heap.new(*args) 
        end

        let(:min_heap) do 
            args = 10.times.map { Random.rand(10) }
            DataStructures101::Heap.new(*args, min_heap: true) 
        end

        it 'creates a max_heap' do
            new_heap = max_heap.merge(min_heap)
            expect(new_heap).to be_a DataStructures101::Heap
            expect(new_heap.min_heap).to be false
        end

        it 'creates a min_heap' do
            new_heap = min_heap.merge(max_heap)
            expect(new_heap).to be_a DataStructures101::Heap
            expect(new_heap.min_heap).to be true
        end
    end

    context 'max heap' do
        let(:heap) do 
            args = 10.times.map { Random.rand(10) }
            DataStructures101::Heap.new(*args) 
        end

        let (:fixed_heap) do 
            DataStructures101::Heap.new(4, 18, 10, 25, 30)
        end

        it 'parents are greater or equal than children' do
            1.upto(9) do |i|
                expect(heap[heap.parent(i)]).to be >= heap[i]
            end
        end

        context 'push' do
            it 'sets the new value in the right location after siftup' do 
                fixed_heap.push(13)
                expect(fixed_heap[2]).to eql(13)
            end
        end

        context 'pop' do 
            it 'returns the root of the heap and reorganizes the heap' do
                result = fixed_heap.pop
                expect(result).to eql(30)
                1.upto(3) do |i|
                    expect(heap[heap.parent(i)]).to be >= heap[i]
                end
            end
        end
    end

    context 'min heap' do
        let(:heap) do 
            args = 10.times.map { Random.rand(10) }
            DataStructures101::Heap.new(*args, min_heap: true) 
        end

        let (:fixed_heap) do 
            DataStructures101::Heap.new(25, 18, 10, 4, 30, min_heap: true)
        end

        it 'parents are greater or equal than children' do
            1.upto(9) do |i|
                expect(heap[heap.parent(i)]).to be <= heap[i]
            end
        end

        context 'push' do
            it 'sets the new value in the right location after siftup' do 
                fixed_heap.push(6)
                expect(fixed_heap[2]).to eql(6)
            end
        end

        context 'pop' do 
            it 'returns the root of the heap and reorganizes the heap' do
                result = fixed_heap.pop
                expect(result).to eql(4)
                1.upto(3) do |i|
                    expect(heap[heap.parent(i)]).to be <= heap[i]
                end
            end
        end
    end
end