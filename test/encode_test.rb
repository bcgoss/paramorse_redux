require 'pry'
require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/paramorse.rb'

class EncoderTest < Minitest::Test

  def test_encoder_exists
    e = Paramorse::Encoder.new

    assert e
  end

  def test_encode_exists
    e = Paramorse::Encoder.new

    assert e.encode("f")
  end

  def test_encode_1_char
    e = Paramorse::Encoder.new

    assert_equal "10111", e.encode("a")
  end

  def test_encode_multiple_chars
    e = Paramorse::Encoder.new

    assert_equal "1110111010111", e.encode("q")
    assert_equal "1", e.encode("e")
    assert_equal "10111011101110111", e.encode("1")
    assert_equal "000000", e.encode(" ")
  end

  def test_will_fail_at_encoding
    e = Paramorse::Encoder.new

    refute e.encode("@")
  end
end
