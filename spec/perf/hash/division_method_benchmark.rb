require_relative '../benchmark_helper'
require_relative 'hash_methods'

class DivisionMethodBenchmark < BenchmarkHelper
  include HashMethods

  def initialize
    super
    @file ||= __FILE__
    compression_lambda =  ->(key, cap) { return key.hash % cap }
    @chained_hash = DataStructures101::ChainedHashTable.new(
        compression_lambda: compression_lambda
    )
    @probe_hash = DataStructures101::ProbeHashTable.new(
        compression_lambda: compression_lambda
    )
  end
end
