module DataStructures101

    class ChainedHashTable < Hash::BaseHashTable

        def initialize(capacity = 31, prime = 109345121, hash_lambda = nil)
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