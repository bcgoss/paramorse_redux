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

    def pop_multiple(number_of_pops)
      results = []
      number_of_pops.times do
        results << @container.pop
      end
      results
    end

    def peek(peek_length = 1)
      @container[-peek_length.. - 1]
    end

    def tail(tail_length = 1)
      @container[0..tail_length - 1].reverse
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
        #binding.pry if char == " "
        encode_character(char)
      end
      morse_sequence = morse_characters.join("000")
      # morse_sequence.delete(" ")
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
      #binding.pry
      morse_words = morse_sequence.split("0000000")
      english_words = morse_words.map do |morse_word|
        english_letters = morse_word.split("000").map do |morse_chars|
          @morse_hash.hash.key(morse_chars)
        end
        english_letters.join
      end
      english_sequence = english_words.join(" ")
      # morse_characters = morse_words.map do |morse_word|
      #   morse_word.split("000")
      # end
      # decoded_characters = morse_characters.map do |character|
      #   @morse_hash.hash.key(character)
      # end
      # sequence = decoded_characters.join
      # sequence.delete(" ")
      # sequence
    end

  end

  class StreamDecoder

  end


end
