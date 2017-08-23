module DataStructures101  
    module Hash
        class BaseHashTable

            attr_reader :size, :hash_lambda

            def initialize(capacity, prime, hash_lambda = nil) 
                @capacity = capacity
                @size = 0

                random = Random.new
                scale = random.rand(prime - 1) + 1
                shift = random.rand(prime)
                
                @hash_lambda =   if hash_lambda.nil?                                   
                                    ->(key) { return (((key.hash * scale + shift) % prime) % @capacity).abs }
                                else
                                    hash_lambda
                                end
                create_table
            end

            def []=(key, value)
                insert(key, value)
            end     

            def insert(key, value)
                old_value = bucket_insert(hash_lambda.call(key), key, value)

                # keep load factor <= 0.5
                resize(new_capacity) if @size > @capacity / 2

                old_value
            end
            
            def [](key)
                bucket_find(hash_lambda.call(key), key)
            end

            def delete(key)
                bucket_delete(hash_lambda.call(key), key)
            end

            private

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
    end
end