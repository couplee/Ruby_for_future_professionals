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
dimensions = [
# [縦, 横]
  [10, 20],
  [30, 40],
  [50, 60]
]

areas = []  # 面積の計算結果を格納する配列

dimensions.each do |dimension|  # ブロック引数が1個だったら、ブロック引数の値が配列になる
  length = dimension[0]
  width = dimension[1]
  areas << length * width
end

areas  #=> [200, 1200, 3000]

  だが、ブロック引数の数を2個にしたら、縦と横の値を別々に受け取ることができて、上のコードよりもシンプルに書ける
dimensions = [
# [縦, 横]
  [10, 20],
  [30, 40],
  [50, 60]
]

areas = []  # 面積の計算結果を格納する配列

dimensions.each do |length, width|  # 配列の要素分だけブロック引数を用意したら、各要素の値が別々の変数に格納される
  areas << length * width
end

areas  #=> [200, 1200, 3000]

  あんまり意味ないけど、ブロック引数が多すぎる場合、はみ出してるブロック引数はnilになる
dimensions.each do |length, width, foo, bar|  # lengthとwidthには値が渡されるけど、fooとbarはnilになる
  p [length, width, foo, bar]
end
#=> [10, 20, nil, nil]
#   [30, 40, nil, nil]
#   [50, 60, nil, nil]

  配列の要素が3個あるのに、ブロック引数が2個しかない場合、3つ目の値が捨てられるが、わかりづらいから特別な理由がない限りこうしたコードを書かないように！
dimensions = [
  [10, 20, 100],
  [30, 40, 200],
  [50, 60, 300]
]

dimensions.each do |length, width|  # 3つの値をブロック引数に渡そうとするが、2つしかないから3つ目の値は捨てられる
  p [length, width]
end
#=> [10, 20]
#   [30, 40]
#   [50, 60]

  ではeach_with_indexみたいに、もとからブロック引数を2つ受け取る場合はどうするか、ためしに|length, width, i|みたいに3つのブロック引数を並べてみる
dimensions = [
  [10, 20],
  [30, 40],
  [50, 60]
]
dimensions.each_with_index do |length, width, i|
  puts "length: #{length}, width: #{width}, i: #{i}"
end
#=> length: [10, 20], width: 0, i:
#   length: [30, 40], width: 1, i:
#   length: [50, 60], width: 2, i:

  結果は、最初のブロック引数lengthに配列が丸ごと渡されてしまった。その影響でブロック引数の割り当てがずれて、widthに添え字が、iにnilが入ってる。
  だから、下記のようにブロック引数を2つにしたら、第1引数で縦と横の値を配列として取得できる
dimensions = [
  [10, 20],
  [30, 40],
  [50, 60]
]

dimensions.each_with_index do |dimension, i|  # いったん配列のまま受け取る
  length = dimension[0]  # 配列から縦と横の値を取り出す
  width = dimension[1]
  puts "length: #{length}, width: #{width}, i: #{i}"
end
#=> length: 10, width: 20, i: 0
#=> length: 30, width: 40, i: 1
#=> length: 50, width: 60, i: 2

  だが一度配列で受け取ってから変数に入れ直すのが面倒。一度でブロック引数で受け取る方法がある。
  下記のように配列の要素を受け取るブロック引数を()で囲んだら、配列の要素を別々の引数として受け取れる
dimensions = [
  [10, 20],
  [30, 40],
  [50, 60]
]

dimensions.each_with_index do |(length, width), i|
  puts "length: #{length}, width: #{width}, i: #{i}"
end
#=> length: 10, width: 20, i: 0
#=> length: 30, width: 40, i: 1
#=> length: 50, width: 60, i: 2

  これで縦の値、横の値、添え字の3つの値を一度にブロック引数で受け取れる




                      💠 4.8.5 ブロックローカル変数
  あんまり使う機会が少ないかもしれないが、ブロック引数を;で区切って、続けて変数を宣言したら、ブロック内でだけ有効な独立したローカル変数を宣言できる（ブロックローカル変数）
numbers = [1, 2, 3, 4]
sum = 0

numbers.each do |n; sum|  # ブロックの外にあるsumとは別物の変数sumを用意する
  sum = 10  # 別物のsumを10で初期化して、ブロック引数の値を加算する
  sum += n
  p sum  # 加算した値をターミナルに表示する
end
#=> 11
#   12
#   13
#   14

sum  #=> 0  # ブロックの中で使ってたsumは別物だから、ブロックの外のsumには変化がない

  ブロックローカル変数の明示的な宣言は、ぶろっくの外と中で”偶然”同じ名前の変数を使ってしまって、不具合を起こす危険性をなくすことができるが、
  この問題は見通しの良いロジックを書いたり、変数に適切な名前をつけたりすることでほとんど防げるはず



              💠 4.8.6 繰り返し処理以外でも使用されるブロック
  ブロックはここで学習したみたいに、配列やハッシュ(第5章で学習する)の繰り返し処理で利用されることが多いが、
  それ以外の場面でもよく利用される。たとえば、以下はテキストファイルに文字列を書き込むコード例
File.open("./sample.txt", "w") do |file|  # sample.txtを開いて文字列を書き込む（クローズ処理は自動的に行われる）
  file.puts("1行目のテキストです。")
  file.puts("2行目のテキストです。")
  file.puts("3行目のテキストです。")
end

  ファイルみたいに外部リソースを扱う場合、「オープンしたら必ずクローズする」という処理が必要になる。
  RubyのFile.openメソッドとブロックを組み合わせると、オープンだけでなく、「必ずクローズする」という処理までFile.opnメソッドが面倒を見てくれるから、
  プログラマはブロック内でファイルに書き込む内容を記述するだけで済んで、「開いたら必ずクローズする」というお約束コードを毎回書かなくてもよくなる。
  なお、ファイルのクローズ処理については、例外処理の説明とあわせて「9.6.2　ensureの代わりにブロックを使う」でも再度学習する



                    💠 4.8.7 do...endと{}の結合度の違い
  すでに学習したように、ブロックはdo...endで書けるし、{}を使って書くこともできる。
  基本的にどっちを使っても結果は同じだけど、do...endよりも{}のほうが結合度が高いという点に注意が必要。
  実際に違いが出るコード例を見てみよう。たとえば、配列のdeleteメソッドにはブロックを渡すことができる。
  ブロックを渡すと引数で指定した値が見つからないときの戻り値を設定するころができる
a = [1, 2, 3]

a.delete(100)  #=> nil  # ブロックを渡さないときは指定した値が見つからないとnilが返る 

a.delete(100) do  #=> ブロックを渡すとブロックの戻り値が指定した値が見つからない時の戻り値になる
  'NG'
end  #=> "NG"

  「2.2.2 メソッド呼び出し」で学習したように、Rubyはメソッドの引数を囲む{}を省略することができる。
  さっきのコードで{}を省略してみよう
a.delete 100 do
  'NG'
end  #=> "NG"
