# frozen_string_literal: true

module DataStructures101
  # @author Rene Hernandez
  # @since 0.2
  module Hash
    # Abstract class for shared HashTable functionalities.
    # @see ChainedHashTable
    # @see ProbeHashTable
    # @author Rene Hernandez
    # @since 0.2
    class BaseHashTable
      include Enumerable

      attr_reader :size, :compression_lambda, :capacity

      def initialize(capacity:, prime:, compression_lambda:)
        @capacity = capacity
        @size = 0
        @table = Array.new(@capacity)

        @compression_lambda = compression_lambda

        return unless @compression_lambda.nil?

        random = Random.new
        scale = random.rand(prime - 1) + 1
        shift = random.rand(prime)
        @compression_lambda = lambda do |key, cap|
          return (((key.hash * scale + shift) % prime) % cap).abs
        end
      end

      def []=(key, value)
        insert(key, value)
      end

      def insert(key, value)
        hash_code = compression_lambda.call(key, @capacity)
        old_value = bucket_insert(hash_code, key, value)

        # Keep load factor below 0.5.
        resize(new_capacity) if @size > @capacity / 2

        old_value
      end

      def [](key)
        bucket_find(compression_lambda.call(key, @capacity), key)
      end

      def delete(key)
        bucket_delete(compression_lambda.call(key, @capacity), key)
      end

      def each
        return enum_for(:each) unless block_given?

        bucket_each do |key, value|
          yield(key, value)
        end
      end

      private

      def new_capacity
        2 * @capacity - 1
      end

      def resize(new_cap)
        @capacity = new_cap

        buffer = map { |key, value| [key, value] }

        @table = Array.new(@capacity)
        @size = 0

        buffer.each { |key, value| self[key] = value }
      end
    end
  end
end
