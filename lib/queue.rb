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
    
    def count
      @container.length
    end
  end
end
