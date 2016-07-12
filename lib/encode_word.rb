require './data/full_morse_hash'
require './lib/encode_letter'
module Paramorse
  class EncodeWord
    def initialize
      @encoder = Paramorse::EncodeLetter.new
      @morse_hash = MorseDictionary.new
    end
    def encode(word)
      morse_chars = word.chars.map do |char|
        @encoder.encode(char)
      end
      morse_chars.join("000")
    end
  end
end
