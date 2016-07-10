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

    assert_equal " ", d.decode("000000")
    assert_equal "u", d.decode("1010111")
    assert_equal "c", d.decode("11101011101")
  end

  def test_decode_multiple_characters_at_once
    # skip
    d = Paramorse::Decoder.new

    assert_equal "ee", d.decode("10001")
    assert_equal "  ", d.decode("000000000000")
    assert_equal " e", d.decode("0000001")
    assert_equal "e ", d.decode("1000000")
    assert_equal " e  ", d.decode("0000001000000000000")
    assert_equal "badger", d.decode("11101010100010111000111010100011101110100010001011101")
  end

  def test_decodes_multiple_words
    # skip
    d = Paramorse::Decoder.new

    assert_equal "ee ee", d.decode("1000100000010001")
    assert_equal "ee ee ", d.decode("1000100000010001000000")
  end
end
