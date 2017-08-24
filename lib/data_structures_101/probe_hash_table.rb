module DataStructures101
    class ProbeHashTable

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
        end
        
        def bucket_delete(hash_code, key)
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