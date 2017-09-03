# frozen_string_literal: true

require 'singleton'

module DataStructures101
  # HashTable implementation using probing strategy for collision-resolution
  # It subclasses Hash::BaseHashTable
  # @author Rene Hernandez
  # @since 0.2
  class ProbeHashTable < Hash::BaseHashTable
    attr_reader :probe_lambda

    def initialize(capacity: 31, prime: 109_345_121,
                   compression_lambda: nil, probe_lambda: nil)
      super(capacity: capacity, prime: prime,
            compression_lambda: compression_lambda)

      @probe_lambda = probe_lambda

      return unless @probe_lambda.nil?

      @probe_lambda = ->(h, i) { return (h + i) % @capacity }
    end

    private

    Sentinel = Class.new do
      include Singleton
    end

    def bucket_find(hash_code, key)
      idx = find_slot(hash_code, key)

      slot_available?(idx) ? nil : @table[idx].last
    end

    def bucket_insert(hash_code, key, value)
      idx = find_slot(hash_code, key)

      unless slot_available?(idx)
        old_value = @table[idx].last
        @table[idx] = [key, value]
        return old_value
      end

      @table[idx] = [key, value]
      @size += 1

      nil
    end

    def bucket_delete(hash_code, key)
      idx = find_slot(hash_code, key)
      return nil if slot_available?(idx)

      value = @table[idx].last
      @table[idx] = Sentinel.instance
      @size -= 1

      value
    end

    def bucket_each
      @table.each do |elem|
        next if elem.nil? || elem == Sentinel.instance

        yield(elem.first, elem.last)
      end
    end

    def find_slot(h, key)
      idx = -1

      j = 0
      loop do
        i = @probe_lambda.call(h, j)
        if slot_available?(i)
          idx = i if idx == -1
          break if @table[i].nil?
        elsif @table[i].first == key
          return i
        end
        j += 1
      end

      idx
    end

    def slot_available?(i)
      @table[i].nil? || @table[i] == Sentinel.instance
    end
  end
end
