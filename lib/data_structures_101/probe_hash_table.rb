require 'singleton'

module DataStructures101
    class ProbeHashTable < Hash::BaseHashTable

        def initialize(capacity = 31, prime = 109345121, hash_lambda = nil)
            super
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

            if !slot_available?(idx)
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

        def find_slot(h, key)
            idx = -1

            i = h
            loop do
                if slot_available?(i)
                    idx = i if idx == -1
                    break if @table[i].nil?
                elsif @table[i].first == key
                    return i
                end

                i = (i + 1) % @capacity
            end

            idx
        end

        def slot_available?(i)
            @table[i].nil? || @table[i] == Sentinel.instance
        end
    end
end