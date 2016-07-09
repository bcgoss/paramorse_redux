require 'pry'
require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/queue_2.rb'

class QueueTest < Minitest::Test

  def test_queue_exists
    q = Queue.new("foo")

    assert q
  end

  def test_queue_has_container
    q = Queue.new("foo")

    assert_equal [], q.container
  end

  def test_can_push_to_container
    # skip
    q = Queue.new("foo")
    q.push("1")

    assert_equal ["1"], q.container
  end

  def test_push_multiple_things
    # skip
    q = Queue.new("foo")
    q.push("badger")
    q.push(1)
    q.push(2)
    q.push(3)


    assert_equal ["badger", 1, 2, 3], q.container
  end

  def test_can_pop_from_container
    qu = Queue.new("foo")
    qu.push(1)
    assert_equal 1, qu.container.pop
    # q = Queue.new
    # q.push("foo")
    # p q.inspect
    # assert_equal "foo", q.pop
  end

  def test_pop_method
    q = Queue.new("foo")
    q.push(1)
    q.push(2)

    assert_equal 2, q.pop
  end


end
