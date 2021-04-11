puts 1 + 2

a = "Hello, world"
puts a

b = "こんにちは"
puts b

# 以下1行コメントアウトされる
1.to_s

c = "こんばんは" 
puts c

d = "おはようございます"
puts d # このコメントもコメントアウトされる

=begin
複数の
コメントアウト1
=end

# 複数の
# コメントアウト2
# こっちの方がよく使われる

def add(a, b)
  a + b
end
puts add(4, 5)

puts "こんにちは\nさようなら"     # \nなどの特殊文字はシングルクォーテーションではなく、ダブルクォーテーションで囲まないと適用されない

name = "Lilly"
puts "Hello, #{name}"     # 式展開もシングルクォーテーションではなく、ダブルクォーテーションで囲まないと適用されない

i = 16
puts "#{i}の16進数は#{i.to_s(16)}です"

name = "Leo"      # ダブルクォーテーションを使う文字列で改行文字や式展開の機能を打ち消したい時は手前に\を記述
puts "Hello, \#{name}"
puts "Hello, \\nLeo"

puts 'He said, "Don\'t speak."'     # シングルクォーテーションの中にシングルクォーテーションを使う場合、中のシングルクォーテーションの手前に\記述
puts "She said, \"It's funny.\""     # ダブルクォーテーションの中にダブルクォーテーションを使う場合、中のダブルクォーテーションの手前に\記述

# 以下はirbで実行する          # 文字列の値が同じか違うか調べる方法
# "Lui" == "Lui"         # true
# "Lui" == "lui"          # false
# "Luna" != "Luna"        # false
# "Luna" != "luna"          # true

# 以下はirbで実行する          # 大小関係を比較。この場合、文字コードが大小比較の基準になる。
# "a" < "b"         # true
# "a" < "A"     # false
# "a" > "A"     # true
# "abc" < "def"      # true
# "abc" < "ab"     # false
# "abc" < "abcd"    # true
# "あいうえお" < "かきくけこ"   # true

