require_relative '../benchmark_helper'
require_relative 'hash_methods'

class QuadraticProbingBenchmark < BenchmarkHelper
  include HashMethods

  def initialize
    super
    @file ||= __FILE__
    @chained_hash = DataStructures101::ChainedHashTable.new
    @probe_hash = DataStructures101::ProbeHashTable.new(
        probe_lambda: ->(h, i, cap) { return (h + i**2) % cap }
    )
  end
end
