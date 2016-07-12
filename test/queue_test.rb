require 'pry'
require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/queue_2.rb'

class QueueTest < Minitest::Test

  def test_queue_exists
    q = ParaMorse::Queue.new

    assert q
  end

  def test_queue_has_container
    q = ParaMorse::Queue.new

    assert_equal [], q.container
  end

  def test_can_push_to_container
    # skip
    q = ParaMorse::Queue.new
    q.push("1")

    assert_equal ["1"], q.container
  end

  def test_push_multiple_things
    # skip
    q = ParaMorse::Queue.new
    q.push("badger")
    q.push(1)
    q.push(2)
    q.push(3)


    assert_equal ["badger", 1, 2, 3], q.container
  end

  def test_can_pop_from_container
    qu = ParaMorse::Queue.new
    qu.push(1)
    assert_equal 1, qu.container.pop

  end

  def test_pop_method
    q = ParaMorse::Queue.new
    q.push(1)
    q.push(2)

    assert_equal 2, q.pop
  end


end
