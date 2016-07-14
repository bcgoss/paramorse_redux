module Paramorse
  class ParallelEncoder
    def initialize
      @output_files = []
    end
    def encode_from_file(source_file, file_count, output_format)
      open_files(source_file, file_count, output_format)
      input_strings = ""
      @input_file.each_line do |line|
        input_strings += line.gsub("\n", "")
      end
      transmit_message(input_strings)
    end

    def open_files(source_file, file_count, output_format)
      @input_file = File.open(source_file)
      file_count.times do |number|
        digits = ("0" + number.to_s)[-2..-1]
        @output_files << File.open(output_format.sub("*",digits), "w")
      end
      @output_files.count
    end

    def transmit_message(input_strings)
      divide_message(input_strings)
      
    end

  end
end
