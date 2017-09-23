# frozen_string_literal: true

# @author Rene Hernandez
# @since 0.2.7
module HashMethods
  def benchmark_methods
    self.class.each_sample do |sample|
      report = do_report do |bench|
        bench.report('ChainedHashTable#insert') do
          sample.each { |i| @chained_hash[i] = i }
        end

        bench.report('ProbeHashTable#insert') do
          sample.each { |i| @probe_hash[i] = i }
        end
      end
      reports[:insert] << report

      report = do_report do |bench|
        bench.report('ChainedHashTable#find') do
          sample.each { |i| @chained_hash[i] }
        end

        bench.report('ProbeHashTable#find') do
          sample.each { |i| @probe_hash[i] }
        end
      end
      reports[:find] << report

      report = do_report do |bench|
        bench.report('ChainedHashTable#delete') do
          sample.each { |i| @chained_hash.delete(i) }
        end

        bench.report('ProbeHashTable#delete') do
          sample.each { |i| @probe_hash.delete(i) }
        end
      end
      reports[:delete] << report
    end
  end

  def graph
    reports.each do |name, rep_entries|
      g = Gruff::Bar.new
      g.title = "#{name.capitalize} for #{graph_title}"
      g.labels = self.class.range_labels
      g.x_axis_label = 'Number of Elements'
      g.y_axis_label = 'Iterations per second'
      g.y_axis_increment = 5
      g.minimum_value = 0
      # Avoids getting a Float vs nil comparision error
      g.maximum_value = 10
      g.show_labels_for_bar_values = true

      klass = 'ChainedHashTable'
      entries = rep_entries.map(&:entries).flatten

      mean_values = entries.select { |e| e.label.start_with?(klass) }
                           .map { |e| e.stats.central_tendency }
      g.data(klass, mean_values)

      klass = 'ProbeHashTable'
      mean_values = entries.select { |e| e.label.start_with?(klass) }
                           .map { |e| e.stats.central_tendency }
      g.data(klass, mean_values)

      g.write(output_file(name))
    end
  end
end
