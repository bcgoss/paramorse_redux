require './test/test_helper'
require './lib/queue.rb'

class QueueTest < Minitest::Test

  def test_queue_exists
    q = Paramorse::Queue.new

    assert q
  end

  def test_container_exits
    q = Paramorse::Queue.new

    assert_equal [], q.container
  end

  def test_can_push_directly_to_container
    q = Paramorse::Queue.new
    q.container.push(1)

    assert_equal [1], q.container
  end

  def test_pop_directly_from_container
    q = Paramorse::Queue.new
    q.container.push(1)

    assert_equal 1, q.container.pop
  end

  def test_push_method
    q = Paramorse::Queue.new
    q.push(1)
    q.push(2)

    assert_equal [1,2], q.container
  end

  def test_pop_method
    q = Paramorse::Queue.new
    q.push(1)

    assert_equal 1, q.pop
  end

  def test_it_pops_multiple
    q = Paramorse::Queue.new
    q.push("1")
    q.push("0")
    q.push("1")

    assert_equal ["1","0","1"], q.pop_multiple(3)
  end

  def test_it_counts
    q = Paramorse::Queue.new
    q.push("1")
    q.push("1")
    q.push("1")
    q.push("0")
    q.push("1")

    assert_equal 5, q.count
  end

  def test_peek_method
    q = Paramorse::Queue.new
    q.push(1)
    q.push(1)
    q.push(0)
    q.push(1)

    assert_equal [1], q.peek(1)
    assert_equal [1,1], q.peek(2)
    assert_equal [1,1,0], q.peek(3)
    assert_equal [1,1,0,1], q.peek(4)
    assert_equal [1,1,0,1], q.peek(50)
  end

  def test_tail_method
    q = Paramorse::Queue.new
    q.push(1)
    q.push(1)
    q.push(0)
    q.push(1)

    assert_equal [1], q.tail(1)
    assert_equal [0,1], q.tail(2)
    assert_equal [1,0,1], q.tail(3)
  end

  def test_flush_empty_queue
    q = Paramorse::Queue.new

    assert_equal [], q.flush
  end

  def test_flush_method
    q = Paramorse::Queue.new
    q.push(1)
    q.push(2)
    q.push(0)

    assert_equal [1,2,0], q.flush
    assert_equal [], q.container
  end

end
