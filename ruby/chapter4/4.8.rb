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



                            💠 4.8.3 添え字を0以外の数値から開始させる
  eachメソッドやwith_indexメソッドを使ったら、繰り返し処理中に添え字が取得できて便利だが、添え字はいつも0から始まる。
  0以外の数値(たとえば1や10)から始めたい場合、with_indexメソッドに引数を渡すと添え字が引数で渡した数値から開始する
fruits = ['apple', 'orange', 'melon']

fruits.each.with_index(1) { |fruit, i| puts "#{i}: #{fruit}" }  # eachで繰り返しながら、1から始まる添え字を取得する
#=> 1: apple
#   2: orange
#   3: melon


fruits.map.with_index(10) { |fruit, i| "#{i}: #{fruit}" }  # mapで処理しながら、10から始まる添え字を取得する
#=> ["10: apple", "11: orange", "12: melon"]

  each_with_indexメソッドには引数を渡せないから、each_with_index(1)ではなく、上のコードみたいにeach_with_index(1)の形で呼び出す必要がある



                            💠 4.8.4 配列がブロック引数に渡される場合
  配列の配列に対して繰り返し処理を実行したら、ブロック引数に配列が渡ってくる。
  たとえば、縦の長さと横の長さを配列に格納して、それを複数用意した配列があったとする
dimensions = [
# [縦, 横]
  [10, 20],
  [30, 40],
  [50, 60]
]

  これをeachメソッドなどで繰り返し処理したら、配列がブロック引数に渡ってくる
