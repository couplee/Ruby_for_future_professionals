            # 🔵 2.6 メソッドの定義

ex)2つの数字を加算するメソッド
def add(a, b)  # メソッド名の書き方はP.36確認
  a + b
end
add(1, 2)  #=> 3
add(5, 7)  #=> 12


returnも使えるが、使わない方が主流
def add(a, b)
  return a + b  # returnは使わない方が主流
end
add(1, 2)  #=> 3


returnはメソッドを途中で脱出する時に使うことが多い
def greeting(country)
  return 'countryを入力してください' if country.nil?  # countryがnilの場合、メッセージ"countryを入力してください"を返してメソッドを抜ける。nil?はオブジェクトがnilの場合にtrueを返すメソッド
  
  if country == "japan"
    "こんにちは"
  else
    "hello"
  end
end
greeting(nil)  #=> "countryを入力してください"
greeting("japan")  #=> "こんにちは"  # ()内のcountryは""で囲む
greeting("china")  #=> "hello"  # ()内のcountryは""で囲む


引数がなかったら()を省略するのが主流だが、()のように書いても大丈夫
def greeting()  # ()は省略するのが主流
  "こんにちは"
end

反対に引数があっても()を省略することはできるが、省略しない方が主流
def greeting country  # 引数のcountryの()を省略することができるが主流ではない
  if country == "japan"
    "こんにちは"
  else
    "hello"
  end
end
greeting "japan"  #=> "こんにちは"
greeting "china"  #=> "hello"