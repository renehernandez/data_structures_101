require 'bundler/setup'
require 'data_structures_101'
require 'benchmark/ips'
require 'gruff'


class BenchmarkHelper

  attr_reader :reports

  def initialize(time: 5, warmup: 2)
    @time = time
    @warmup = warmup
    @reports = Hash.new {|hash, key| hash[key] = []}
  end

  private

  def graph_title
    File.basename(@file, '.rb').split('_').
          map(&:capitalize).join(' ')
  end

  def graph_name
    File.basename(@file, '.rb')
  end

  def output_file(suffix_name)
    path = File.join(File.expand_path('../..', __dir__), 'docs', 'graphs', 'hash')

    FileUtils.mkdir_p path

    File.join path, "#{graph_name}_#{suffix_name}.png"
  end

  def do_report
    return Benchmark.ips do |bench|
      bench.config(time: @time, warmup: @warmup)

      yield bench

      bench.compare!
    end
  end

  def self.range_labels
    range.each_with_object({}).
        with_index do |(val, hash), idx|
          hash[idx] = commafy(val)
        end
  end

  def self.range
    [20_000, 40_000, 60_000, 80_000, 100_000]
  end

  def self.commafy(num)
    num.to_s.chars.reverse.
      each_with_object("").
      with_index do |(val, str), idx|
        str.prepend((idx % 3).zero? ? val + ',' : val)
      end.chop
  end

  def self.each_sample
    range.each do |n|
      top = 3 * n / 4
      yield Array.new(n) { rand(1...top) }
    end
  end
end
