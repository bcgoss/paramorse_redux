require './lib/queue'
require './lib/file_operation'
require './lib/stream_decoder'
module Paramorse
  class ParallelDecoder
    attr_accessor :target_file, :coded_files, :queues
    def initialize
      @coded_files = []
      @queues = []
      @file_writer = Paramorse::FileDecoder.new
    end
    
    def decode_from_files(file_count, coded_file_name_format, target_file_name)
      open_files(target_file_name, file_count, coded_file_name_format)
      coded_queues = read_into_queues
      plain_text_queues = parse_queues(coded_queues)
      message = merge_queues(plain_text_queues)
      @target_file.write(message)
    end
    
    def open_files(target_file_name, file_count, coded_file_name_format)
      @target_file = File.open(target_file_name, "w")
      file_count.times do |number|
        @queues << Paramorse::StreamDecoder.new
        digits = ("0" + number.to_s)[-2..-1]
        coded_files << File.open(coded_file_name_format.sub("*",digits))
      end
      coded_files.count
    end
    
    def read_into_queues
      coded_files.each_with_index do |coded_file, index|
        coded_file.each_line do |line|
          line.chars.each do |bit|
            queues[index].receive(bit)
          end
        end
      end
      return queues
    end
    
    def parse_queues(coded_queues)
      decoded_queues = coded_queues.map do |queue|
        queue.letter_queue
      end
      return decoded_queues
    end
    
    def merge_queues(queues)
      message = ""
      while queues.any? {|queue| queue.is_empty?}
        queues.map do |queue|
          message += queue.pop || ""
        end
      end
      return message
    end
    
    def write_file(message)
      counter = @target_file.write(message)
    end
  end    
end
