require './lib/paramorse'
module Paramorse
  class FileEncoder
    def initialize
      @encoder = Paramorse::Encoder.new
    end

    def encode(plain_text_file_name, encoded_text_file_name)
      plain_text_lines = read_file(plain_text_file_name)
      count = write_file(encoded_text_file_name, plain_text_lines)
      return count
    end
    
    def read_file(plain_text_file_name)
      plain_text_handle = File.open(plain_text_file_name, "r")
      plain_text_lines = []
      plain_text_handle.each_line do |line|
        plain_text_lines << line
      end
      return plain_text_lines
    end
    
    def write_file(encoded_text_file_name, plain_text_lines)
      encoded_text_handle = File.open(encoded_text_file_name, "w")
      encoded_lines = plain_text_lines.map do |line|
        @encoder.encode(line)
      end
      count = 0
      encoded_lines.each do |line|
        count += encoded_text_handle.write(line + "\n")
      end
      count
    end
  end

  class FileDecoder
    def initialize
      @decoder = Paramorse::Decoder.new
    end

    def decode(encoded_text_file_name, plain_text_file_name)
      encoded_lines = read_file(encoded_text_file_name)
      count = write_file(plain_text_file_name, encoded_lines)
      return count
    end

    def read_file(encoded_text_file_name)
      encoded_text_handle = File.open(encoded_text_file_name, "r")
      encoded_lines = []
      encoded_text_handle.each_line do |line|
        encoded_lines << line.chomp
      end
      return encoded_lines
    end
        
    def write_file(plain_text_file_name, encoded_lines)
      plain_text_handle = File.open(plain_text_file_name, "w")
      plain_text_lines = encoded_lines.map do |line|
        @decoder.decode(line)
      end
      count = 0
      plain_text_lines.each do |line|
        count += plain_text_handle.write(line + "\n")
      end
      return count
    end
  end
end
