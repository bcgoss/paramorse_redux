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
      @container[-peek_length..-1]
    end
    def tail(tail_length = 1)
      @container[0..tail_length-1]
    end
  end

  class Encoder
    def initialize
      @morse_hash = MorseDictionary.new
      @queue = Queue.new
    end
    def encode(character)
      @queue.push(character)
      @morse_hash.hash[character]
    end
  end

  class Decoder
    def initialize
      @morse_hash = MorseDictionary.new
    end
    def decode(morse_sequence)
      @morse_hash.hash.key(morse_sequence)
    end
  end


end
