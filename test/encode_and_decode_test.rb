require 'pry'
require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/paramorse.rb'

class EncodeAndDecodeTest < Minitest::Test
  def test_encode_and_decode_1_char
    e = Paramorse::Encoder.new
    d = Paramorse::Decoder.new
    test_string = "a"
    encoded_string = e.encode(test_string)
    decoded_string = d.decode(encoded_string)
    assert_equal test_string, decoded_string

  end

  def test_decode_and_encdoe_1_char
    e = Paramorse::Encoder.new
    d = Paramorse::Decoder.new
    test_string = "111"
    decoded_string = d.decode(test_string)
    encoded_string = e.encode(decoded_string)
    assert_equal test_string, encoded_string
  end

  def test_multi_character_integration
    e = Paramorse::Encoder.new
    d = Paramorse::Decoder.new
    test_string = "badger"
    encoded_string = e.encode(test_string)
    decoded_string = d.decode(encoded_string)
    assert_equal test_string, decoded_string

    assert_equal encoded_string, e.encode(d.decode(encoded_string))
  end

  def test_multi_words_with_spaces
    e = Paramorse::Encoder.new
    d = Paramorse::Decoder.new
    test_string = "rogue one"
    encoded_string = e.encode(test_string)
    # p encoded_string
    # binding.pry if encoded_string.include?(" ")
    decoded_string = d.decode(encoded_string)
    # puts decoded_string
    # binding.pry if encoded_string.include?(" ")

    assert_equal test_string, decoded_string
    assert_equal encoded_string, e.encode(d.decode(encoded_string))
    # puts encoded_string
    # binding.pry if encoded_string.include?(" ")
    puts
  end

  def test_a_sentence
    e = Paramorse::Encoder.new
    d = Paramorse::Decoder.new
    test_string = "the quick brown fox jumped over the lazy dog"
    encoded_string = e.encode(test_string)
    decoded_string = d.decode(encoded_string)
    assert_equal test_string, decoded_string
  end


  def test_mean_stuff
    skip
    e = Paramorse::Encoder.new
    d = Paramorse::Decoder.new
    test_string = "   lets see how EaSy  This Is   "
    encoded_string = e.encode(test_string)
    decoded_string = d.decode(encoded_string)
    assert_equal test_string.downcase, decoded_string
  end

end
