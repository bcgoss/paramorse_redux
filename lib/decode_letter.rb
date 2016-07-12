require 'pry'
require './data/full_morse_hash'
module Paramorse
  class DecodeLetter
    def initialize
      @morse_hash = MorseDictionary.new
    end

    def decode(morse_chars)
      morse_chars.chomp!("0")
      @morse_hash.hash.key(morse_chars)
    end
  end
end
