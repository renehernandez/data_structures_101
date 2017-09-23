# frozen_string_literal: true

require_relative '../benchmark_helper'
require_relative 'hash_methods'

# @author Rene Hernandez
# @since 0.2.7
class DefaultBenchmark < BenchmarkHelper
  include HashMethods

  def initialize
    super
    @file ||= __FILE__
    @chained_hash = DataStructures101::ChainedHashTable.new
    @probe_hash = DataStructures101::ProbeHashTable.new
  end
end
