require 'pry'
require './data/full_morse_hash'
require './lib/decode_letter'
module Paramorse
  class DecodeWord
    def initialize
      @decoder = Paramorse::DecodeLetter.new
    end
    def decode(morse_word)
      decoded_words = morse_word.split("000").map do |morse_chars|
        @decoder.decode(morse_chars)
      end
      decoded_words.join("")
    end
  end
end
