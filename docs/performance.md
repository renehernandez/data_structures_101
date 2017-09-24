Besides the tests suite, it is also possible to run performance comparisons between implementation variations of the same data structures.

#### What are we benchmarking?

To aid in our quest of benchmarking the ruby code, we use [benchmark-ips](https://github.com/evanphx/benchmark-ips) to get data about the number of iteration per seconds for a given block of code.

#### Graph results

To help with the results visualization and spotting patterns on the data, the benchmark classes generate graphs results using [Gruff](https://github.com/topfunky/gruff).

#### BenchmarkHelper

All benchkmark comparisons subclass `BenchmarkHelper` to reuse some utility methods and string helpers. At the same time it brings a common convention about to proceed for the performance testing. You can find the existing benchmark implementations at [https://github.com/renehernandez/data_structures_101/tree/master/perf](https://github.com/renehernandez/data_structures_101/tree/master/spec/perf).

#### Rake task for performance

Since the performance tests are not rspec-based, they cannot be run through the rspec cli. Instead, there is a set of rake tasks to run our performance tests. By loading [perf.rake](https://github.com/renehernandez/data_structures_101/blob/master/tasks/perf.rake) on the rake file we can run and generate the corresponding graphs for the analyses.