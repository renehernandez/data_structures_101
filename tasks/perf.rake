Dir.glob("#{File.dirname(__FILE__)}/../spec/perf/hash/*.rb") { |r| load r}

namespace :perf do
  namespace :hash do

    desc 'Benchmarks default hashes objects'
    task :default_hash do
      bench = DefaultBenchmark.new
      bench.benchmark_methods
      bench.graph
    end

    desc 'Benchmarks hashes using division method for compression'
    task :division_method do
      bench = DivisionMethodBenchmark.new
      bench.benchmark_methods
      bench.graph
    end

    desc 'Benchmarks hashes using quadratic probe for ProbeHash'
    task :quadratic_probing do
      bench = QuadraticProbingBenchmark.new
      bench.benchmark_methods
      bench.graph
    end
  end

  desc 'Runs all hashes benchmarks'
  task :hash => ['hash:default_hash', 'hash:division_method', 'hash:quadratic_probing']
end