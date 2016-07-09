require 'pry'
require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/paramorse.rb'

class DecoderTest < Minitest::Test
  def test_decoder_exits
    d = Paramorse::Decoder.new

    assert d
  end

  def test_decode_1_character
    d = Paramorse::Decoder.new

    assert "e", d.decode("1")
  end

  def test_decode_multiple_characters
    d = Paramorse::Decoder.new

    assert_equal " ", d.decode("000000")
    assert_equal "u", d.decode("1010111")
    assert_equal "c", d.decode("11101011101")
  end
end
