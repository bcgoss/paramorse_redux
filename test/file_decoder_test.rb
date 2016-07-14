require 'pry'
require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/file_operation.rb'

class FileDecoderTest < Minitest::Test
  def test_file_decoder_exists
    file_decoder = Paramorse::FileDecoder.new
    assert_instance_of Paramorse::FileDecoder, file_decoder
  end

  def test_it_can_decode
    file_decoder = Paramorse::FileDecoder.new
    assert_respond_to file_decoder, :decode

    assert_equal 3, file_decoder.decode("encoded_test_file.txt", "decoded_text.txt")
  end
end
