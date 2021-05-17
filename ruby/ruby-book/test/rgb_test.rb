require 'minitest/autorun'
require './lib/rgb'  # libフォルダの中にrgb.rbファイル作成&作成したrgb,rbファイルにコードを記述後、この行を追記

class RgbTest < Minitest::Test
  def test_to_hex
    assert_equal '#000000', to_hex(0, 0, 0)
    assert_equal '#ffffff', to_hex(255, 255, 255)
    assert_equal '#043c78', to_hex(4, 60, 120)
  end
end
