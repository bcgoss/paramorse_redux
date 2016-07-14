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
    assert_respond_to encoder, :divide_message
    assert_respond_to encoder, :write_message
  end

  def test_it_encodes_from_file
    encoder = Paramorse::ParallelEncoder.new
    assert_equal 161354, encoder.encode_from_file('./test/data/input.txt', 8, './test/data/output*.txt')
  end

  def test_it_opens_files
    encoder = Paramorse::ParallelEncoder.new
    assert_equal 8, encoder.open_files('./test/data/input.txt', 8, './test/data/output*.txt')
  end

  def test_it_writes_messages
    encoder = Paramorse::ParallelEncoder.new
    encoder.output_files << File.open("./test/data/hello.txt","w")
    encoder.output_files << File.open("./test/data/world.txt", "w")

    assert_equal 110, encoder.write_message(["hlowrd","el ol"])
  end

  def test_it_divides_messages
    encoder = Paramorse::ParallelEncoder.new
    encoder.output_files << File.open("./test/data/output00.txt")
    encoder.output_files << File.open("./test/data/output01.txt")

    encoder.divide_message("hello world")
    assert_equal 2, encoder.divide_message("hello world").count
  end


end
