require './test/test_helper'
require './lib/paramorse.rb'

class EncoderTest < Minitest::Test

  def test_encoder_exists
    e = Paramorse::Encoder.new

    assert e
  end

  def test_encode_exists
    e = Paramorse::Encoder.new

    assert_respond_to e, :encode
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
    assert_equal "1", e.encode(" e")
    assert_equal "100000001", e.encode(" e e")
  end

  def test_will_fail_at_encoding
    e = Paramorse::Encoder.new

    assert_equal "", e.encode("@")
  end

  def test_ignores_case
    e = Paramorse::Encoder.new

    assert_equal "1", e.encode("E")
  end

  def test_encode_multiple_chars_at_once
    e = Paramorse::Encoder.new

    assert_equal "10001", e.encode("ee")
    assert_equal "100010001", e.encode("eee")
  end

  def test_can_encode_word
    e = Paramorse::Encoder.new

    assert_equal "11101010100010111000111010100011101110100010001011101",\
      e.encode("badger")
  end

  def test_can_encode_with_space
    e = Paramorse::Encoder.new
    assert_equal "10001000000010001", e.encode("ee ee")
    # assert_equal "00000001000100000000000000100010000000", e.encode(" ee  ee ") # doesn't pass yet. multiple white spce is hard

  end

  def test_it_knows_shakespear
    encoder = Paramorse::Encoder.new
    assert_equal "101110111000101010100010111000111000000010111010100010100011"\
    +"101110100010101010001110000000111000101010100010111010001110111011100010"\
    +"101110001110111010001010101000000011101011101110001110111011100011101000"\
    +"111010100010001011101000000010111011100010100011101000111010100011101110"\
    +"1110001011101110000000111010101000101110100010001011100011101011100010101"\
    , encoder.encode("what light through yonder window breaks")

  end

end
