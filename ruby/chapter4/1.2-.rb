                      💠 4.1.1 この章の例題：RGBカラー変換プログラム
  今回はRubyでRGBカラーを変換するプログラムを作る。RGBカラー変換プログラムの使用は下記の通り。
    ・10進数を16進数に変換するto_hexメソッドと、16進数を10進数に変換するto_intsメソッドの二つを定義する。
    ・to_hexメソッドは3つの整数を受け取って、それぞれを16進数に変換した文字列を返す。文字列の先頭には"#"をつける。
    ・to_intsメソッドはRGBカラーを表す16進数文字列を受け取って、R、G、Bのそれぞれを10進数の整数に変換した値を配列として返す。
    
    
    
                        💠 4.1.2 RGBカラー変換プログラムの実行例
to_hex(0, 0, 0)  #=> '#000000'
to_hex(255, 255, 255)  #=> '#ffffff'
to_hex(4, 60, 120)  #=> '#043c78'
  
to_ints('#000000')  #=> [0, 0, 0]
to_ints('#ffffff')  #=> [255, 255, 255]
to_ints('#043c78')  #=> [4, 60, 120]



                        💠 4.2 配列
  配列とは複数のデータをまとめて格納できるオブジェクトのこと。配列は下記のように[]と,を使って作成する(配列リテラル)
[]  # 空の配列を作る
[要素1, 要素2, 要素3]  # 3つの要素が格納された配列を作る


  配列はArrayクラスのオブジェクトになってる
[].class  #=> Array  # 空の配列を作成して、そのクラス名を確認する


  下記は数値の1,2,3が格納された配列を変数aに代入するコード例
a = [1, 2, 3]

  上記のコード例を下記のように改行して書くこともできる
a = [
      1,
      2,
      3  # 最後の要素に,をつけても文法上エラーにならない
]


  配列は数値に限らず、どんなオブジェクトも格納できる。下記は配列の中に文字列を格納する例
a = ['apple', 'orange', 'melon']

  異なるデータ型を格納することもできる。下記は数値と文字列を混ぜた配列を作成する例
a = [1, 'apple', 2, 'orange', 3, 'melon']

  配列の中に配列を含めることもできる
a = [[10, 20, 30], [40, 50, 60], [70, 80, 90]]


  配列の各要素を取得する場合、[]と添字(数字)を使う。最初の要素の添字は0
a = [1, 2, 3]
a[0]  #=> 1  # 1つ目の要素を取得する
a[1]  #=> 2  # 2つ目の要素を取得する
a[2]  #=> 3  # 3つ目の要素を取得する

  存在しない要素を指定してもエラーではなく、nilが返ってくる
a = [1, 2, 3]
a[100]  #=> nil

  sizeメソッド(エイリアスメソッドはlength)を使うと配列の長さ(要素の個数)を取得できる
a = [1, 2, 3]
a.size  #=> 3
a.length  #=> 3



                      💠 4.2.1 要素の変更、追加、削除
  変更：下記の構文ように添字を指定して値を代入すると、指定した要素を変更することができる
配列[添字] = 新しい値

  下記のコードは2番目の要素を20に変更するコード例
a = [1, 2, 3]
a[1] = 20
a  #=> [1, 20, 3]

  元の配列の大きさよりも大きい添字を指定したら、間の値がnilで埋められる(今回は元の配列の大きさが3に対して、5番目の要素を設定した場合の実行結果は、4番目の要素がnilになる点に注目)
a = [1, 2, 3]
a[4] = 50
a  #=> [1, 2, 3, nil, 50]

  追加：<<を使って配列の最後に要素を追加することができる
a = []
a << 1
a << 2
a << 3
a  #=> [1, 2, 3]

  削除：配列内の特定の位置にある要素を削除したい場合、delete_atメソッドを使う
a = [1, 2, 3]

a.delete_at(1)  #=> 2  # 2番目の要素を削除する(削除した値が戻り値になる)
a  #=> [1, 3]

a.delete_at(100)  #=> nil  # 存在しない添え字を指定するとnilが返ってくる
a  #=> [1, 3]



                  💠 4.2.2 配列を使った多重代入
  第2章では変数を多重代入する方法を習った
a, b = 1, 2
a  #=> 1
b  #=> 2

  右辺に配列を置いた場合も同じように多重代入することができる
a, b = [1, 2]
a  #=> 1
b  #=> 2

  右辺に数が少ない場合はnilが返ってくる
c, d = [10]
c  #=> 10
d  #=> nil

  右辺の数が多い場合ははみ出した値が切り捨てられる
e, f = [100, 200, 300]
e  #=> 100
f  #=> 200


  配列の多重代入は便利に使える。たとえば、Rubyのdivmodメソッド(割り算の商と余りを配列として返すメソッド)などの場合、配列で受け取るよりも多重代入を使って最初から別々の変数に入れた方がすっきりとしたコードが書ける
14.divmod(3)  #=> [4, 2]  # divmodメソッドは商と余りを配列で返す

quo_rem = 14.divmod(3)  #=> [4, 2]  # 戻り値を値のまま受け取る
"商=#{quo_rem[0]}, 余り=#{quo_rem[1]}"  #=> "商=4, 余り=2"
  上記のコードを多重代入で別々の変数として受け取る
quotient, remainder = 14.divmod(3)  #=> [4, 2]
"商=#{quotient}, 余り=#{remainder}"  #=> "商=4, 余り=2"