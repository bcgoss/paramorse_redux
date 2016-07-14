require './lib/paramorse'
require './lib/file_operation'
module Paramorse
  class ParallelEncoder
    attr_accessor :output_files
    def initialize
      @output_files = []
      @message_fragments = []
      @encoder = Paramorse::Encoder.new
      @file_writer = Paramorse::FileEncoder.new
    end
    
    def encode_from_file(source_file, file_count, output_format)
      open_files(source_file, file_count, output_format)
      input = @input_file.read.gsub("\n", "")
      input_as_array = divide_message(input)
      write_message(input_as_array)
    end

    def open_files(source_file, file_count, output_format)
      @input_file = File.open(source_file)
      file_count.times do |number|
        digits = ("0" + number.to_s)[-2..-1]
        @output_files << File.open(output_format.sub("*",digits), "w")
      end
      @output_files.count
    end
    
    def divide_message(input)
      input_as_array = []
      file_count = @output_files.count
      file_count.times { input_as_array << "" }
      input.chars.each_with_index do |char, index|
        current_file = index % file_count
        input_as_array[current_file] += char
      end
      return input_as_array
    end
    
    def write_message(input_strings)
      count = 0
      @output_files.each_with_index do |output_file, index|
        count += @file_writer.write_file(output_file, [input_strings[index]])
      end
      count 
    end
  end
end
