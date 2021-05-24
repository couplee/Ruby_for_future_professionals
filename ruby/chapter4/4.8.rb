                      ブロックについてもっと詳しく
                      
                      💠 4.8.1 添え字付きの繰り返し処理
  Rubyではeachメソッドを使って繰り返し処理を行う場合が大半だが、eachメソッドでは何番目の要素を処理してるか、ブロック内で判別できない。
  だから繰り返し処理をしながら、処理してる要素の添え字も取得したいときは、each_with_indexメソッドを使うと便利。
  このメソッドを使ったらブロック引数の第2引数に添え字を渡してくれる。
fruits = ['apple', 'orange', 'melon']
fruits.each_with_index { |fruit, i| puts "#{i}: #{fruit}" }  # ブロック引数のiには0, 1, 2...と要素の添え字が入る
#=> 0: apple
#   1: orange
#   2: melon



                      💠 4.8.2 with_indexメソッドを使った添え字付きの繰り返し処理
  4.8.1でeach_with_indexメソッドを学習したが、これだとeachメソッドの代わりしか使えない。
  たとえば、mapメソッドで繰り返し処理をしながら、添え字も同時に取得したいときなどの場合、mapメソッドとwith_indexメソッドを組み合わせる
fruits = ['apple', 'orange', 'melon']
fruits.map.with_index { |fruit, i| "#{i}: #{fruit}" }  # mapとして処理しつつ、添え字も受け取る。
#=> ["0: apple", "1: orange", "2: melon"]

  with_indexメソッドはmap以外のメソッドとも組み合わせれる
fruits = ['apple', 'orage', 'melon']
fruits.delete_if.with_index { |fruit, i| fruit.include?('a') && i.odd? }  # 名前に"a"を含んで、且つ添え字が奇数である要素を削除する
#=> ["apple", "melon"]

  with_indexメソッドはEnumeratorクラスのインスタンスメソッドであり、またeachメソッドやmapメソッド、delete_ifメソッドなど繰り返し処理を行うメソッドの大半はブロックを省略して呼び出すと、Enumeratorオブジェクトを返すようになってる
fruits = ['apple', 'orange', 'melon']
fruits.each  #=> #<Enumerator: ["apple", "orange", "melon"]:each> 
fruits.map  #=> #<Enumerator: ["apple", "orange", "melon"]:map> 
fruits.delete_if  #=> #<Enumerator: ["apple", "orange", "melon"]:delete_if> 

  だからwith_indexメソッドはさまざまな繰り返し処理用のメソッドと組み合わせて実行できるように”見える”