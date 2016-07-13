module Paramorse
  class ParallelEncoder
    def initialize
      @output_files = []
    end
    def encode_from_files(source_file, file_count, output_format)
      @input_handle = File.open(source_file)
      file_count.times do |number|
        @output_files << File.open(output_format.gsub("*", "#{number}"), "w")
      end
    end
  end
end
