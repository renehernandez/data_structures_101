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

        context 'push' do
            let (:fixed_heap) do 
                DataStructures101::Heap.new(4, 18, 10, 25, 30)
            end
            
            it 'sets the new value in the right location after siftup' do 
                fixed_heap.push(13)
                expect(fixed_heap[2]).to eql(13)
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

        context 'push' do
            let (:fixed_heap) do 
                DataStructures101::Heap.new(25, 18, 10, 4, 30, min_heap: true)
            end
            
            it 'sets the new value in the right location after siftup' do 
                fixed_heap.push(6)
                expect(fixed_heap[2]).to eql(6)
            end
        end
    end
end