module DataStructures101

  class LinkedList
    include Enumerable

    class Node
      attr_accessor :value, :prev, :next

      def initialize(value, prev = nil, _next = nil)
        @value = value
        @next = _next
        @prev = prev
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

    def each(&block)
      curr = head.next
      until curr.nil?
        block.call(value)
        curr = curr.next
      end
    end

    def fetch(index)
      fetch_node(index).value
    end

    def insert(index, *values)
      curr = fetch_node(index)

      curr = index < 0 ? curr : curr.prev

      values.each do |value|
        curr = add_node(value, curr.next)
      end
      self
    end

    def first(*args)
      if args.size == 0
        return @head.next.value
      end

      if args.size > 1
        raise ArgumentError, "wrong number of arguments (given #{args.size}, expected 1)"
      end

      if args.first < 0
        raise ArgumentError, "negative array size"
      end

      return new_list_from_range(0, args.first - 1)
    end

    def last(*args)
      if args.size == 0
        return @tail.prev.value
      end

      if args.size > 1
        raise ArgumentError, "wrong number of arguments (given #{args.size}, expected 1)"
      end

      if args.first < 0
        raise ArgumentError, "negative array size"
      end

      return new_list_from_range(size - args.first, size - 1)
    end

    def push(*values)
      values.each do |value|
        add_node(value, @tail)
      end
      self # Allows to concatenate consecutive calls to push
    end

    private

    def fetch_node(index)
      index += size if index < 0
      if index < 0 || index >= size
        raise IndexError, "index #{index} outside of array bounds: #{-size}...#{size}"
      end

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

      return new_list if size == 0 || start_index == size || finish_index == -1

      start_index = 0 if start_index < 0
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
