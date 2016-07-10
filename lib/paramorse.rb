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

    def peek(peek_length = 1)
      @container[-peek_length..-1].reverse
    end

    def tail(tail_length = 1)
      @container[0..tail_length-1]
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
      encoded_characters = ""
      @queue.flush

      content.chars.each do |char|
        @queue.push(char)
      end
      @queue.container.each do |char|
        encoded_characters += encode_character(char)
        if @queue.container.count >1
          encoded_characters += "000"
        end
      end
      delete_trailing_zeros(encoded_characters)
      encoded_characters.delete(" ")
    end

    def delete_trailing_zeros(encoded_characters)
      3.times do
        encoded_characters.chop! if encoded_characters.end_with?("0")
      end
      encoded_characters
    end

    def encode_character(character)
      encoded_character = @morse_hash.hash[character]
      unless encoded_character
        return ""
      end
      encoded_character
    end
  end

  class Decoder
    def initialize
      @morse_hash = MorseDictionary.new
    end

    def decode(morse_sequence)
      morse_sequence.gsub!("000000", "000 000")
      morse_characters = morse_sequence.split("000")
      morse_characters.map! do |character|
        @morse_hash.hash.key(character)
      end
      morse_characters.join
    end
  end


end
