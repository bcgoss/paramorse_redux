require 'pry'
require './data/full_morse_hash'
module Paramorse

  class Queue
    attr_reader :container
    def initialize
      @container = []
    end

    def push(data)
      @container.push(data)
    end

    def pop
      @container.pop
    end

    def pop(number_of_pops)
      results = []
      number_of_pops.times do
        results << @container.pop
      end
      results
    end

    def peek(peek_length = 1)
      @container[-peek_length..-1]
    end

    def tail(tail_length = 1)
      @container[0..tail_length-1].reverse
    end

    def flush
      results = []
      @container.length.times do
        results << pop
      end
      results.reverse
    end
  end

  class Encoder
    def initialize
      @morse_hash = MorseDictionary.new
      @queue = Queue.new
    end

    def encode(content)
      content.downcase!
      content.strip!
      morse_characters = content.chars.map do |char|
        encode_character(char)
      end
      morse_sequence = morse_characters.join("000")
      morse_sequence.delete(" ")
    end


    def encode_character(character)
      encoded_character = @morse_hash.hash[character]
      unless encoded_character
        return ""
      end
      encoded_character
    end

    def delete_trailing_zeros(encoded_characters)
      until encoded_characters.end_with?("1")
        encoded_characters.chop!
      end
      encoded_characters
    end

  end

  class Decoder
    def initialize
      @morse_hash = MorseDictionary.new
    end

    def decode(morse_sequence)
      spaces_added_sequence = morse_sequence.gsub("000000", "000 000")
      morse_characters = spaces_added_sequence.split("000")
      decoded_characters = morse_characters.map do |character|
        @morse_hash.hash.key(character)
      end
      sequence = decoded_characters.join
      sequence.delete(" ")
      sequence
    end

  end

  class StreamDecoder

  end


end
