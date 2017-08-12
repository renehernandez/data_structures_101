module DataStructures101
    
    module Hash

        class BaseHashTable

            attr_reader :size

            def initialize(capacity, prime) 
                @capacity = capacity
                @prime = prime
                random = Random.new
                @scale = random.rand(@prime - 1) + 1
                @shift = random.rand(@prime)
                @size = 0
                create_table
            end

            def []=(key, value)
                insert(key, value)
            end     

            def insert(key, value)
                old_value = bucket_insert(hash_value(key), key, value)

                # keep load factor <= 0.5
                resize(new_capacity) if @size > @capacity / 2

                old_value
            end
            
            def [](key)
                bucket_find(hash_value(key), key)
            end

            def delete(key)
                bucket_delete(hash_value(key), key)
            end

            private
            def hash_value(key)
                (((key.hash * @scale + @shift) % @prime) % @capacity).abs
            end

            def new_capacity()
                2 * capacity - 1
            end

            def resize(new_capacity)
                @capacity = new_capacity

                buffer = self.map { |key, value| [key, value] }

                create_table
                @size = 0

                buffer.each { |key, value| self[key] = value }
            end
        end

        class Bucket

            attr_reader :table

            def initialize()
                @table = []
            end

            def [](key)
                find(key)
            end

            def []=(key, value)
                insert(key, value)
            end

            def insert(key, value)
                idx = @table.find_index {|_key, _| _key == key} 

                if idx.nil?
                    @table << [key, value]
                    return nil
                else
                    value, @table[idx][1] = @table[idx][1], value
                    return value
                end
            end

            def size()
                @table.size
            end

            def find(key)
                pair = @table.find {|_key, _| _key == key}
                pair.nil? ? nil : pair[1]
            end

            def delete(key) 
                idx = @table.find_index {|_key, _| _key == key}
                return nil if idx.nil?

                value = @table[idx][1]
                @table[idx] = @table.last if idx != @table.size - 1
                @table.pop
                value
            end

        end
    end


    class ChainHashTable < Hash::BaseHashTable

        include Enumerable

        def initialize(capacity = 31, prime = 109345121)
            super
            @table = []
        end

        private

        def bucket_find(hash_code, key)
            bucket = @table[hash_code]
            return nil if bucket.nil?

            bucket.find(key)
        end

        def bucket_insert(hash_code, key, value)
            bucket = @table[hash_code]
            bucket = @table[hash_code] = Hash::Bucket.new if bucket.nil?

            old_size = bucket.size()
            old_value = bucket.insert(key, value)
            @size += (bucket.size - old_size)

            old_value
        end

        def bucket_delete(hash_code, key)
            bucket = @table[hash_code]
            return nil if bucket.nil?

            old_size = bucket.size
            value = bucket.delete(key)
            @size -= (old_size - bucket.size)

            value
        end

        def create_table()
            @table = Array.new(@capacity)
        end
    end

end