require './lib/queue'
require './lib/file_operation'
module Paramorse
  class ParallelDecoder
    attr_accessor :target_file, :coded_files
    def initialize
      @coded_files = []
      @file_writer = Paramorse::FileDecoder.new
    end
    
    def decode_from_files(file_count, coded_file_name_format, target_file_name)
      open_files(target_file_name, file_count, coded_file_name_format)
      read_into_queues
      parse_queues
      message = merge_queues
      @target_file.write(message)
    end
    
    def open_files(target_file_name, file_count, coded_file_name_format)
      @target_file = File.open(target_file_name, "w")
      file_count.times do |number|
        digits = ("0" + number.to_s)[-2..-1]
        coded_files << File.open(coded_file_name_format.sub("*",digits))
      end
      coded_files.count
    end
    
    def read_into_queues
      coded_files.each_line do |line|
        
      end
    end
    
    def parse_queues
      
    end
    
    def merge_queues
      
    end
    
    def write_file(message)
      @target_file.write(message)
    end
  end    
end
