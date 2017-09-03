# frozen_string_literal: true

module DataStructures101
  # @author Rene Hernandez
  # @since 0.1
  class LinkedList
    include Enumerable

    # Internal class to store a given value in the LinkedList.
    # Provides reference to next and previous node in the list
    # @see LinkedList
    # @author Rene Hernandez
    # @since 0.1
    class Node
      attr_accessor :value, :prev, :next

      def initialize(value, previous_node = nil, next_node = nil)
        @value = value
        @prev = previous_node
        @next = next_node
      end

      def to_s
        "<value=#{value}>"
      end
    end

    attr_reader :size

    def initialize(*values)
      @size = 0
      @head = Node.new(nil)
      @tail = Node.new(nil, @head)
      @head.next = @tail

      push(*values)
    end

    def <<(value)
      push(value)
    end

    def delete(value)
      curr = @head.next
      return_value = nil
      until curr == @tail
        if curr.value == value
          remove_node(curr)
          return_value = curr.value
        end
        curr = curr.next
      end

      return_value
    end

    def each
      return enum_for(:each) unless block_given?

      curr = head.next
      until curr.nil?
        yield curr.value
        curr = curr.next
      end
    end

    def fetch(index)
      fetch_node(index).value
    end

    def insert(index, *values)
      curr = fetch_node(index)

      curr = index.negative? ? curr : curr.prev

      values.each do |value|
        curr = add_node(value, curr.next)
      end
      self
    end

    def first(n = nil)
      return @head.next.value if n.nil?

      raise ArgumentError, 'negative array size' if n.negative?

      new_list_from_range(0, n - 1)
    end

    def last(n = nil)
      return @tail.prev.value if n.nil?

      raise ArgumentError, 'negative array size' if n.negative?

      new_list_from_range(size - n, size - 1)
    end

    def push(*values)
      values.each do |value|
        add_node(value, @tail)
      end
      self # Allows to concatenate consecutive calls to push
    end

    private

    def fetch_node(index)
      index += size if index.negative?

      error_msg = "index #{index} outside of array bounds: #{-size}...#{size}"
      raise IndexError, error_msg if index.negative? || index >= size

      pos = 0
      curr = @head.next
      while pos < index
        curr = curr.next
        pos += 1
      end

      curr
    end

    def add_node(value, next_node)
      node = Node.new(value, next_node.prev, next_node)
      node.prev.next = node
      node.next.prev = node
      @size += 1
      node
    end

    def remove_node(node)
      node.prev.next = node.next
      node.next.prev = node.prev
      @size -= 1
    end

    def new_list_from_range(start_index, finish_index)
      new_list = LinkedList.new

      return new_list if size.zero? || start_index == size || finish_index == -1

      start_index = 0 if start_index.negative?
      finish_index = size - 1 if finish_index >= size

      start_node = fetch_node(start_index)
      finish_node = fetch_node(finish_index)

      until start_node == finish_node.next
        new_list << start_node.value
        start_node = start_node.next
      end

      new_list
    end
  end
end
