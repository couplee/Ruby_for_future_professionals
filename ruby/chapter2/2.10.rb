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
