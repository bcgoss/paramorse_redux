require 'pry'
require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/file_operation.rb'

class FileEncoderTest < Minitest::Test
  def test_file_encoder_exists
    file_encoder = Paramorse::FileEncoder.new
    assert_instance_of Paramorse::FileEncoder, file_encoder
  end

  def test_it_can_encode
    file_encoder = Paramorse::FileEncoder.new
    assert_respond_to file_encoder, :encode

    assert_equal 14, file_encoder.encode("plain_text.txt", "encoded_text.txt")
  end
end
