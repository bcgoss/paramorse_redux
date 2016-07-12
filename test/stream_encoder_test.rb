require 'pry'
require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/paramorse.rb'

class StreamDecoderTest < Minitest::Test

  def test_stream_decoder_exists
    s = Paramorse::StreamDecoder.new
    assert_instance_of Paramorse::StreamDecoder, s
  end

  def test_it_receives_bits
    stream = Paramorse::StreamDecoder.new
    assert_respond_to stream, :receive

    stream.receive("1")
    assert_equal ["1"], stream.bit_queue.container
  end

  def test_it_decodes_the_letter_e
    stream = Paramorse::StreamDecoder.new
    stream.receive("1")
    assert_equal "e", stream.decode
  end

  def test_it_decodes_the_word_the
    stream = Paramorse::StreamDecoder.new
    
    assert_equal "the", stream.decode
  end
end
