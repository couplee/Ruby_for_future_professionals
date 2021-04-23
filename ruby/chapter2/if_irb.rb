Rubyのif文は最後に評価される式を戻り値として返すから、"irb"などで実行する場合、putsを使わなくてもif文の戻り値で、どの条件が実行されたかわかる
country = "italy"
if country == "japan"
  "こんにちは"
elsif country == "us"
  "Hello"
elsif country == "italy"
  "ciao"
else
  "???"
end  #=> "ciao"

「if文は戻り値を返す」性質を利用して、if文の戻り値を変数に代入することもできる
country = "italy"
greeting = 
if country == "japan"
  "こんにちは"
elsif country == "us"
  "Hello"
elsif country == "italy"
  "ciao"
else
  "???"
end

greeting  #=> "ciao"(greetingって入力する度に"ciao"が出力されるようになった)


          # 🔵 if文の修飾子（文の後ろにif文を置く）

毎月1日だけポイント5倍にする場合の普通のif文
point = 7
day = 1
if day = 1
  point *= 5
end
point  #=> 35

上のif文のコードを修飾子にする場合
point = 7
day = 1
point *= 5 if day == 1
point  #=> 35


        # 🔵 if文にthenを挿入すると処理を1行に押し込めることもできる(使用頻度はあまり高くない)
country = "italy"
if country == "japan" then "こんにちは"
elsif country == "us" then "Hello"
elsif country == "italy" then "ciao"
else "???"
end  #=> "ciao"