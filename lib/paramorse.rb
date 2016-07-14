require 'pry'
require './data/full_morse_hash'
require './lib/decode_word'
require './lib/encode_word'
module Paramorse

  class Encoder
    def initialize
      @encoder = Paramorse::EncodeWord.new
      @morse_hash = MorseDictionary.new
    end

    def encode(content)
      trailing_spaces = handle_edge_spaces(content)
      content.downcase!
      words = content.split(" ")
      morse_words = words.map do |word|
        @encoder.encode(word)
      end
      morse_words.join(@morse_hash.hash[" "]) \
        + @morse_hash.hash[" "] * trailing_spaces
    end

    def handle_edge_spaces(content)
      trailing_spaces = 0
      while content.end_with?(" ")
        content.chomp!(" ")
        trailing_spaces += 1
      end
      return trailing_spaces
    end
  end

  class Decoder
    def initialize
      @morse_hash = MorseDictionary.new
      @decoder = DecodeWord.new
    end

    def decode(morse_sequence)
      trailing_spaces = handle_edge_spaces(morse_sequence)
      morse_words = morse_sequence.split("0000000")
      english_words = morse_words.map do |morse_word|
        @decoder.decode(morse_word)
      end
      english_words.join(" ") + " " * trailing_spaces
    end

    def handle_edge_spaces(morse_sequence)
      trailing_spaces = 0
      if morse_sequence.end_with?("0000000")
        morse_sequence.chomp!("0000000")
        trailing_spaces = handle_edge_spaces(morse_sequence) + 1
      end
      return trailing_spaces
    end
  end
end
