module DataStructures101  
    module Hash
        class BaseHashTable
            include Enumerable

            attr_reader :size, :compression_lambda, :capacity

            def initialize(capacity:, prime:, compression_lambda:) 
                @capacity = capacity
                @size = 0
                @table = Array.new(@capacity)
                           
                @compression_lambda = compression_lambda
                
                if @compression_lambda.nil?      
                    random = Random.new
                    scale = random.rand(prime - 1) + 1
                    shift = random.rand(prime)                             
                    @compression_lambda = ->(key, cap) { return (((key.hash * scale + shift) % prime) % cap).abs }
                end
            end

            def []=(key, value)
                insert(key, value)
            end     

            def insert(key, value)
                old_value = bucket_insert(compression_lambda.call(key, @capacity), key, value)

                # keep load factor <= 0.5
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

                buffer = self.map { |key, value| [key, value] }

                @table = Array.new(@capacity)
                @size = 0

                buffer.each { |key, value| self[key] = value }
            end
        end
    end
end