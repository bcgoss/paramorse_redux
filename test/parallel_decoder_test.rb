require './test/test_helper'
require './lib/parallel_decoder'
require './lib/queue'
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
      decoder = Paramorse::ParallelDecoder.new
      decoder.open_files("./test/data/decoded.txt", 8, "./test/data/output*.txt")
      assert_equal  8, decoder.read_into_queues.count
  end

  def test_it_merges_queues
    decoder = Paramorse::ParallelDecoder.new
    queues = []
    queues << Paramorse::Queue.new
    queues << Paramorse::Queue.new
    "hello world".chars.each_with_index do |char, index|
      queues[index % 2].push(char)
    end
    assert_equal "hello world", decoder.merge_queues(queues)
  end

  def test_it_writes_a_message
    decoder = Paramorse::ParallelDecoder.new
    decoder.target_file = File.open("./test/data/test.txt", "w")
    assert_equal 11, decoder.write_file("hello world")
  end

  def test_it_decodes_a_single_stream
    decoder = Paramorse::ParallelDecoder.new
    decoder.decode_from_files(2, "./test/data/hello*.txt","./test/data/two_stream.txt")

  end
  def test_it_does_the_thing
    decoder = Paramorse::ParallelDecoder.new

    assert_equal 905, decoder.decode_from_files(1, './test/data/obama*.txt', './test/data/decoded.txt')
    assert_equal 17853, decoder.decode_from_files(8, './test/data/obama*.txt', './test/data/decoded.txt')
  end
end
