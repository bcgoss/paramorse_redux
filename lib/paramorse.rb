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
      content.downcase!
      content.strip!
      words = content.split(" ")
      morse_words = words.map do |word|
        @encoder.encode(word)
      end
      morse_words.join("0000000")
    end

    def delete_trailing_zeros(encoded_characters)
      until encoded_characters.end_with?("1")
        encoded_characters.chomp!("0")
      end
      encoded_characters
    end

  end

  class Decoder
    def initialize
      @morse_hash = MorseDictionary.new
      @decoder = DecodeWord.new
    end

    def decode(morse_sequence)
      morse_words = morse_sequence.split("0000000")
      english_words = morse_words.map do |morse_word|
        @decoder.decode(morse_word)
      end
      english_sequence = english_words.join(" ")
      english_sequence.strip
    end

  end

  class StreamDecoder
    attr_reader :bit_queue
    def initialize
      @bit_queue = Paramorse::Queue.new
      @decoder = Paramorse::Decoder.new
    end

    def receive(bit)
      @bit_queue.push(bit)
    end

    def decode
      code = @bit_queue.flush.join
      @decoder.decode(code)
    end

    def check_for_word
      
    end
  end
end
