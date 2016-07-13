require 'pry'
require './lib/queue'
require './lib/paramorse'

module Paramorse
  class StreamDecoder
    attr_reader :bit_queue
    def initialize
      @bit_queue = Paramorse::Queue.new
      @letter_queue = Paramorse::Queue.new
      @decoder = Paramorse::Decoder.new
      @signal = false
    end

    def receive(bit)
      @bit_queue.push(bit)
      @letter_queue.push(decode) if contains_a_letter?
    end

    def decode
      code = get_letter_or_space
      @decoder.decode(code)
    end

    def contains_a_letter?
      if @bit_queue.peek(22).join.include? "1000"
        return true
      elsif @bit_queue.peek(7).join == "0000000"
        false
      end
    end

    def get_letter_or_space
      # if @bit_queue.join.include? "1000"
      #   code = []
    #     until @bit_queue.peek(3).join == "000"
    #       code << @bit_queue.pop
    #     end
    #     @letter_queue.push(@decoder.decode(code.join))
    #   end
    #
    #   while bit_queue.peek(7).join == "0000000"
    #     code = []
    #     code = pop_multiple(7)
    #     letter_queue.push(@decoder.decode(code.join))
    #   end
    #
    #   if bit_queue.peek(4).join == "0001"
    #     @bit_queue.pop_multiple(3)
    #   end
    end
  end
end