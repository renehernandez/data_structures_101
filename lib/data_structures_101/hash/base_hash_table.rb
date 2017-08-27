module DataStructures101  
    module Hash
        class BaseHashTable
            include Enumerable

            attr_reader :size, :hash_lambda, :capacity

            def initialize(capacity:, prime:, hash_lambda:) 
                @capacity = capacity
                @size = 0
                @table = Array.new(@capacity)
                           
                @hash_lambda = hash_lambda
                
                if @hash_lambda.nil?      
                    random = Random.new
                    scale = random.rand(prime - 1) + 1
                    shift = random.rand(prime)                             
                    @hash_lambda = ->(key) { return (((key.hash * scale + shift) % prime) % @capacity).abs }
                end
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

                buffer = self.map { |key, value| [key, value] }

                @table = Array.new(@capacity)
                @size = 0

                buffer.each { |key, value| self[key] = value }
            end
        end
    end
end