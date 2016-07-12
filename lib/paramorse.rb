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
      @container.shift
    end

    def pop_multiple(number_of_pops)
      results = []
      number_of_pops.times do
        results << @container.shift
      end
      results
    end

    def peek(peek_length = 1)
      @container[0 .. peek_length - 1]
    end

    def tail(tail_length = 1)
      @container[- tail_length .. - 1]
    end

    def flush
      results = []
      @container.length.times do
        results << pop
      end
      results
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
      words = content.split(" ")
      morse_words = words.map do |word|
        morse_chars = word.chars.map do |char|
          encode_character(char)
        end
        morse_chars.join("000")
      end
      morse_words.join("0000000")
      # morse_characters = content.chars.map do |char|
      #   #binding.pry if char == " "
      #   encode_character(char)
      # end
      # morse_sequence = morse_characters.join("000")
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
      binding.pry if morse_sequence == '00000001'
      morse_words = morse_sequence.split("0000000")
      english_words = morse_words.map do |morse_word|
        english_letters = morse_word.split("000").map do |morse_chars|
          @morse_hash.hash.key(morse_chars)
        end
        english_letters.join
      end
      english_sequence = english_words.join(" ")
      english_sequence.strip
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
