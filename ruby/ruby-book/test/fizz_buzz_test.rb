require 'minitest/autorun'
require './lib/fizz_buzz'  # Rubyを実行してるディレクトリがパスの起点になるrequireと違って、自分のファイルパス(今回はfizz_buzz_test.rb)を起点にして読み込むファイルを指定する場合、require_relativeを使う(今回だとrequire_relative '../lib/fizz_buzz'になる)
  # 下記のFizzBuzzTestはクラス名（キャメルケース）で慣習としてTestで終わるかTestで始まる名前をつけることが多い。※またテストコードが書かれたファイルのファイル名（スネークケース）もクラス名と合わせる（今回だとfizz_buzz_test.rbが好ましい）
class FizzBuzzTest < Minitest::Test  # Minitest::TestはFizzBuzzTestクラスがMinitest::クラスを継承することを表す(第7章で説明する)
  def test_fizz_buzz  # Minitestはtest_で始まるメソッドを探して、それを実行するから、メソッド名をtest_で始めることが必須。test_から後ろの部分はメソッド内でテストする内容が推測できるような名前を付ける。なお、テストクラス内ではtest_で始まるメソッドを複数定義してもいい。Minitestはtest_で始まるメソッドを全て実行する
    assert_equal '1', fizz_buzz(1)  # assert_equalはMinitestが提供してるメソッド。構文はassert_equal 期待する結果, テスト対象となる値や
    assert_equal '2', fizz_buzz(2)
    assert_equal 'Fizz', fizz_buzz(3)
    assert_equal '4', fizz_buzz(4)
    assert_equal 'Buzz', fizz_buzz(5)
    assert_equal 'Fizz', fizz_buzz(6)
    assert_equal 'Fizz Buzz', fizz_buzz(15)
  end
end
