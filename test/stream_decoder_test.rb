require 'pry'
require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/stream_decoder'

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

  def test_it_decodes_the_word_hi
    stream = Paramorse::StreamDecoder.new
    stream.receive("1")
    stream.receive("0")
    stream.receive("1")
    stream.receive("0")
    stream.receive("1")
    stream.receive("0")
    stream.receive("1")
    stream.receive("0")
    stream.receive("0")
    stream.receive("0")
    stream.receive("1")
    stream.receive("0")
    stream.receive("1")
    stream.receive("0")
# => "hi"
    assert_equal "hi", stream.decode
  end

  def test_it_finds_letters_in_streams
    stream = Paramorse::StreamDecoder.new
    assert_respond_to stream, :contains_a_letter?
    encoder = Paramorse::Encoder.new
    phrase = encoder.encode("ab")
    decoded_letters = []
    phrase.chars do |bit|
      stream.receive(bit)
      if stream.contains_a_letter?
        decoded_letters << stream.decode
      end
    end
    decoded_letters << stream.decode
    assert_equal "ab", decoded_letters.join
  end
end
