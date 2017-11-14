# frozen_string_literal: true

module DataStructures101
  # Heap implementation
  # @author Rene Hernandez
  # @since 0.3
  class Heap

    def initialize(*args, min_heap: false)
      @data = args
      @heap_check = ->(i, j) { return @data[i] >= @data[j] }

      if min_heap
        @heap_check = ->(i, j) { return @data[i] <= @data[j] }
      end

      build_heap
    end

    def left(i)
      2 * i + 1
    end

    def right(i)
      2 * (i + 1)
    end

    def parent(i)
      i / 2
    end

    private

    def buil_heap
      start = data.length / 2

      start.downto(1) { |i| heapify(i) }
    end

    def heapify(i)
      l = left(i)
      r = right(i)

      head = i
      head = l if l < @data.size && @heap_check.call(l, head)
      head = r if r < @data.size && @heap_check.call(r, head)

      if head != i
        data[i], data[head] = data[head], data[i]
        heapify(head)
      end
    end
  end
end
