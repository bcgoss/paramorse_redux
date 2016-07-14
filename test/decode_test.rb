require 'pry'
require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/paramorse.rb'

class DecoderTest < Minitest::Test
  def test_decoder_exits
    # skip
    d = Paramorse::Decoder.new

    assert d
  end

  def test_decode_1_character
    # skip
    d = Paramorse::Decoder.new

    assert "e", d.decode("1")
    assert "t", d.decode("111")
  end

  def test_decode_multiple_characters
    # skip
    d = Paramorse::Decoder.new

    assert_equal "", d.decode("0000000")
    assert_equal "u", d.decode("1010111")
    assert_equal "c", d.decode("11101011101")
  end

  def test_decode_multiple_characters_at_once
    # skip
    d = Paramorse::Decoder.new

    assert_equal "ee", d.decode("10001")
    #assert_equal "  ", d.decode("00000000000000") #spec: discard leading and trailing 0's
    assert_equal " e", d.decode("00000001")
    assert_equal "e", d.decode("10000000")
    assert_equal " e", d.decode("0000000100000000000000")
    assert_equal "badger", d.decode("11101010100010111000111010100011101110100010001011101")
  end

  def test_decodes_multiple_words
    # skip
    d = Paramorse::Decoder.new

    assert_equal "ee ee", d.decode("10001000000010001")
    assert_equal "ee ee", d.decode("100010000000100010000000")
  end

  def test_it_decodes_shakespear
    decoder = Paramorse::Decoder.new

    assert_equal "what light through yonder window breaks", decoder.decode("1011101110001010101000101110001110000000101110101000101000111011101000101010100011100000001110001010101000101110100011101110111000101011100011101110100010101010000000111010111011100011101110111000111010001110101000100010111010000000101110111000101000111010001110101000111011101110001011101110000000111010101000101110100010001011100011101011100010101")
  end
end
