require 'pry'

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

  def peek(peek_length)
    @container[-peek_length..-1]
  end

  def tail(tail_length)
    @container[0..tail_length-1]
  end

end
