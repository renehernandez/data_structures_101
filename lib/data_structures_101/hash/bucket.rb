module DataStructures101
    module Hash
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
                pair.nil? ? nil : pair.last
            end

            def delete(key) 
                idx = @table.find_index {|_key, _| _key == key}
                return nil if idx.nil?

                value = @table[idx].last
                @table[idx] = @table.last if idx != @table.size - 1
                @table.pop
                value
            end

        end
    end
end