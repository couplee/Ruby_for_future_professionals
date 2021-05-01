         # 💠 2.10.1 &&や||の戻り値と評価を終了するタイミング
  &&や||を使っても、式全体の戻り値は必ずしもtrueまたはfalseとは限らない。
  Rubyは式全体が偽であることが決定するまでは左辺から順に式を評価する。
  式全体が真か偽か確定すると、式の評価を終了し、最後に評価した式の値を返す。
  ex) &&
1 && 2 && 3  #=> 3 # 全ての式を評価する必要があったから、最後の式である3が戻り値になった
1 && nil && 3  #=> nil # 2つめのnilを評価した時点で式全体の真偽値が偽であることが確定したため、そこで評価を終了し、最後の式であるnilが戻り値になった
1 && false && 3  #=>false
1 && false && nil  #=> false
  ex) ||
nil || false  #=> false
false || nil  #=> nil
nil || false || 2 || 3  #=> 2 # 2を評価した時点で式全体の真偽値が真であることが確定したため、2が戻り値になった
false || 2 || 3 || nil  #=> 2
nil || 2 || 3 || false  #=> 2
false || 2 || false  #=> 2

  以下は||を使った式の戻り値や、真偽値が確定した時点で評価が終了されることを活用した架空コードの例
user = find_user('Alice') || find_user('Bob') || find_user('Carol')  # Alice、Bob、Carolを順に検索し、最初に見つかったユーザ(nilまたはfalse以外の値)を変数に格納する式
user.valid? && send_email_to(user)  # 正常なユーザであればメールを送信する(左辺が偽であればメール送信は実行されない)


                     # 💠 2.10.2 優先順位が低いand、or、not
  and、or、notは&&、||、!に近い働きをする演算子
t1 = true
f1 = false
t1 and f1  #=> false
t1 or f1  #=> true
not t1  #=> false
  だが、下記のように、and、or、notは演算子の優先順位が低いから、&&、||、!とまったく同じように使うことができない
高い !
     &&
     ||
     not
低い and or
  ex) 英語の論理演算子と記号の論理演算子を混在させたりしたら結果が異なることがある
t1 = true
f1 = false
!f1 || true  #=> true  # !は||よりも優先順位が高い
not f1 || t1  #=> false  # notは||よりも優先順位が低い
  また、&&、||と違い、andとorは優先順位に違いがないため、()を使わない時は左から右に順番に真偽値が評価されていく
  ex)
t1 = true
t2 = true
f1 = false

t1 || t2 && f1  #=> true  # &&は||よりも優先順位が高い t1 || (t2 && f1)
t1 or t2 and f1  #=> false  # andとorは優先順位が同じだから、左から順に評価される (t1 or t2) and f1

  だから、andやorを&&や||の代わりに使うと不具合を招く可能性がある。andやorは条件分岐で使わず、制御フローを扱うのに向いている。
  ex) 下記は前項で使った「正常なユーザであれば、そのユーザにメールを送信する」という架空のコードから、メソッドを呼び出して丸括弧をなくしたものだが、このままだと構文エラーが発生する
user.valid? && send_email_to user  # (user.valid? && send_email_to) userのように解釈されたため、エラーになる
  だが、&&の代わりにandを使うと構文エラーにならずに、「正常なユーザであればm、そのユーザにメールを送信する」という制御フローを実行できる
user.valid? and send_email_to user  # andを使用すると(user.valid?) and (send_email_to user)のように解釈されるためエラーにならない
  しかし、&&を使う場合でも、send_email_to(user)と書けば、1つの処理であることが明確になるため、構文エラーにならない
user.valid? && send_email_to(user)
  また、orも「Aが真か？  真でなければBせよ」という制御フローを実現する際に便利。
def greeting(country)
  country or return 'countryを入力してください'  # countryがnil(またはfalse)ならメッセージを返してメソッド抜ける
  
  if country == 'japan'
    'こんにちは'
  else
    'hello'
  end
end
greeting(nil)  #=> "countryを入力してください"
greeting('japan')  #=> "こんにちは"



           # 💠 2.10.3 unless文
  Rubyにはifと反対の意味を持つunlessがある。条件式が偽になった時だけ処理を実行する。if文で否定の条件を書いてる時は、unless文に書き換えれる。
  ex) 以下はif文
status = 'error'
if status != 'ok'
  '何か以上があります'
end  #=> "何か異常があります"
  ex)上記のif文を下記のようにunlessに書き換えれる
status = 'ok'
unless status == 'ok'
  '何か異常があります'
else
  '正常です'
end  #=> "正常です"

  だがunless文にはif文のelsifのようなelsunlessという条件分技はない。
  またunlessはifと同じように、unlessの戻り値を直接変数に代入したり、修飾子として文の後ろに置いたり、thenを入れることができる
  ex) unlessの結果を変数に代入する
status = 'error'

message =   # unlessの結果を変数に代入する
  unless status == 'ok'
    '何か異常があります'
  else
    '正常です'
  end
message  #=> '何か異常があります'

  ex) unlessを修飾子として使う
'何か異常があります' unless status == 'ok'  #=> "何か異常があります"

  ex) thenを入れる
status = 'error'
unless status == 'ok' then
  '何か異常があります'
end  #=> "何か異常があります"


  if+否定条件は、unless+肯定条件に書き直すことができるが、必ず書き直さないといけないわけではない。
  if文の方が読みやすい場合、if+否定条件のままにしても大丈夫



    # 💠 2.10.4 case文
  複数の条件を指定する時は、elsifを重ねるよりもcase文で書いた方がシンプルになる。
  ex) case文の構文
case 対象のオブジェクトや式
when 値1
  値1に一致する場合の処理
when 値2
  値2に一致する場合の処理
when 値3
  値3に一致する場合の処理
else
  どれにも一致しない場合の処理
end

  2.5.3 if文の説明で使ったサンプルコードをcase文に書き直す場合
  ex) if文を使う場合
country = 'italy'

if country == 'japan'
  'こんにちは'
elsif country == 'us'
  'Hello'
elsif country == 'italy'
  'ciao'
else
  '???'
end  #=> "ciao"
  ex) case文を使う場合
case country

when 'japan'
  'こんにちは'
when 'us'
  'Hello'
when 'italy'
  'ciao'
else
  '???'
end  #=> "ciao"


  また、Rubyのcase文ではwhen節に複数の値を指定して、どれかに一致すれば処理を実行する、という条件分技を書くことができる
  ex) when節に複数の値を指定する
country = 'アメリカ'
case country
when 'japan', '日本'
  'こんにちは'
when 'us', 'アメリカ'
  'Hello'
when 'italy', 'イタリア'
  'ciao'
else
  "???"
end  #=> "Hello"


  if文と同じように、case文も最後に評価された式を戻り値として返すから、case文の結果を変数に入れることができる
country = 'italy'

message =
  case country
  when 'japan'
    'こんにちは'
  when 'us'
    'Hello'
  when 'italy'
    'ciao'
  else
    '???'
  end
  
message  #=> "ciao"


  when節の後ろにはthenを入れることができる。thenを入れると以下の式のようにwhen節とその条件が真だった場合の処理を1行で書けるが、使用頻度は低い
country = 'italy'

case country
when 'japan' then 'こんにちは'
when 'us' then 'Hello'
when 'italy' then 'ciao'
else '???'
end  #=> "ciao"


          # 💠 2.10.5 条件演算子（三項演算子）
  RubyではC言語と同じような?を使った条件分技(三項演算子)を使うことができる。下記は構文
  式 ? 真だった場合の処理 : 偽だった場合の処理

  ex) 2.5.3 if文の説明で下記のようなコード例を使った
n = 11
if n > 10
  '10より大きい'
else
  '10以下'
end  #=> "10より大きい"

  上記のコードは条件演算子を使うと下記のように書き直すことができる
n = 11
n > 10 ? '10より大きい' : '10以下'  #=> "10より大きい"


  下記のように、条件分技した結果を変数に代入することも可能
n = 11
message = n >10 ? '10より大きい' : '10以下'
message  #=> "10より大きい"

  ※️シンプルなif/else文の場合、条件演算子を使った方がスッキリ書ける場合がある。逆に複雑な条件文の場合、反対に読みづらくなることもあるから、コードの可読性を考慮しながら利用するようにする




                 # 💠 2.11.2 ?で終わるメソッド
  Rubyのメソッド名は?や!で終わらせることができる。?で終わるメソッドは慣習として真偽値を返すメソッドになってる。下記はRubyで最初から用意されてるメソッドの中から、いくつかピックアップ
    ex) 空文字列はtrue、違う場合false
''.empty?  #=> true
'abc'.empty?  #=> false

    ex) 引数の文字列が含まれてたらtrue、違う場合false
'watch'.include?('at')  #=> true
'watch'.include?('in')  #=> false

    ex) 奇数ならtrue、偶数ならfalse
1.odd?  #=> true
2.odd?  #=> false

    ex) 偶数ならtrue、奇数ならfalse
1.even?  #=> false
2.even?  #=> true

    ex) オブジェクトがnilならtrue、違う場合false
nil.nil?  #=> true
'abc'.nil?  #=> false
1.nil?  #=> false


  ?で終わるメソッドは自分で定義することができる。真偽値を返す目的のメソッドであれば、?で終わらせるようにした方がいい
ex) 3の倍数ならtrue、それ以外はfalseを返す
def multiple_of_three?(n)
  n % 3 == 0
end

multiple_of_three?(4)  #=> false
multiple_of_three?(5)  #=> false
multiple_of_three?(6)  #=> true



                   💠 2.11.3 !で終わるメソッド
  !で終わるメソッドは慣習として「使用する時は注意が必要」という意味を持つ。
  例えば、Stringクラスにはupcaseメソッドとupcase!メソッドという2つのメソッドがある。
  どっちも文字列を大文字にするメソッドだけど、upcaseメソッドは"大文字に変えた新しい文字列を返して、呼び出した文字列自身は変化しない"。
  だが、upcase!メソッドは"呼び出した文字列自身を大文字に変更する"
    ex)
a = 'ruby'

a.upcase  #=>"RUBY"
a  #=> "ruby"  # upcaseだと変数aの値は変化しない

a.upcase!  #=> "RUBY"
a  #=> "RUBY"  # upcase!だと変数aの値も大文字に変わる


  ?で終わるメソッドと同様、!で終わるメソッドも自分で定義することができる。
    ex) 引数として渡された文字列を逆順に並び替えて、さらに大文字に変更する破壊的メソッド(約14行下で説明)を定義してる
def reverse_upcase!(s)
  s.reverse!.upcase!
end
s = 'ruby'
reverse_upcase!(s)  #=> "YBUR"
s  #=> "YBUR"


  メソッド名は!や?で終わることができるが、変数名には!や?を使えない（エラーになる）
odd? = 1.odd?  #=> SyntaxError
upcase! = 'ruby'.upcase!  #=> SyntaxError


  upcase!メソッドみたいに、呼び出したオブジェクトの状態を変更してしまうメソッドのことを「破壊的メソッド」と呼ぶ
  !で終わるメソッドは?で終わるメソッドほど慣習が明確ではない。破壊的メソッドがすべて!で終わるわけではないし、
  破壊的メソッドではないメソッド(たとえば不正な状態で呼び出すとエラーを発生させるメソッドなど)に!をつける時もある。
  いずれにしても!で終わるメソッドには何かしらの注意事項があるはずだから、!で終わるメソッドを見かけたらどんな注意事項があるか、APIドキュメントなどを読んで確認する。