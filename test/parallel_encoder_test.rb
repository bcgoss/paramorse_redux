require './test/test_helper'
require './lib/parallel_encoder'

class ParallelEncoderTest < Minitest::Test
  def test_it_exists
    assert Paramorse::ParallelEncoder.new
  end

  def test_it_has_methods
    encoder = Paramorse::ParallelEncoder.new
    assert_respond_to encoder, :encode_from_file
    assert_respond_to encoder, :open_files
    assert_respond_to encoder, :transmit_message
  end

  def test_it_encodes_from_file
    encoder = Paramorse::ParallelEncoder.new
    encoder.encode_from_file('./test/data/input.txt', 8, './test/data/output*.txt')
    # I don't know how to test this?
  end

  def test_it_opens_files
    encoder = Paramorse::ParallelEncoder.new
    assert_equal 8, encoder.open_files('./test/data/input.txt', 8, './test/data/output*.txt')
  end

  def test_it_sends_messages
    encoder = Paramorse::ParallelEncoder.new
  end
end
