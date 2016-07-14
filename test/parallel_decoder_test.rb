require './test/test_helper'
require './lib/parallel_decoder'

class ParallelDecoderTest < Minitest::Test
  def test_it_exists
    assert Paramorse::ParallelDecoder.new
  end

  def test_it_has_methods
    decoder = Paramorse::ParallelDecoder.new
    assert_respond_to decoder, :decode_from_files
    assert_respond_to decoder, :open_files
    assert_respond_to decoder, :read_into_queues
    assert_respond_to decoder, :parse_queues
    assert_respond_to decoder, :merge_queues
    assert_respond_to decoder, :write_file
  end
  
  def test_it_opens_files
    decoder = Paramorse::ParallelDecoder.new
    assert_equal 8, decoder.open_files("./test/data/decoded.txt", 8, "./test/data/output*.txt")
  end
  
  def test_it_reads_into_queues
      
  end
  
  def test_it_merges_queues
  end
  
  def test_it_writes_a_message
    decoder = Paramorse::ParallelDecoder.new
    decoder.target_file = File.open("./test/data/test.txt", "w")
    assert_equal 11, decoder.write_file("hello world")
  end
end