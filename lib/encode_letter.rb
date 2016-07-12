require 'pry'
require './data/full_morse_hash'
module Paramorse
  class EncodeLetter
    def initialize
      @morse_hash = MorseDictionary.new
    end

    def encode(english_char)
      @morse_hash.hash[english_char]
    end
  end
end
