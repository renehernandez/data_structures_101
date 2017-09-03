# frozen_string_literal: true

module DataStructures101
  module Hash
    # Utility class to manipulate (key, pairs) that have same hash code.
    # @see ChainedHashTable
    # @author Rene Hernandez
    # @since 0.2
    class Bucket
      attr_reader :table

      def initialize
        @table = []
      end

      def [](key)
        find(key)
      end

      def []=(key, value)
        insert(key, value)
      end

      def insert(key, value)
        idx = @table.find_index { |table_key, _| table_key == key }

        if idx.nil?
          @table << [key, value]
          return nil
        else
          value, @table[idx][1] = @table[idx][1], value
          return value
        end
      end

      def size
        @table.size
      end

      def find(key)
        pair = @table.find { |table_key, _| table_key == key }
        pair.nil? ? nil : pair.last
      end

      def delete(key)
        idx = @table.find_index { |table_key, _| table_key == key }
        return nil if idx.nil?

        value = @table[idx].last
        @table[idx] = @table.last if idx != @table.size - 1
        @table.pop
        value
      end

      def each
        return enum_for(:each) unless block_given?

        @table.each do |key, value|
          yield(key, value)
        end
      end
    end
  end
end
