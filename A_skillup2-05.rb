# 座標系での向きの変わる移動 (paizaランク B 相当)

class Coordinate
  # 方角 N:0, E:1, S:2, W:3
  @@direction = ["N", "E", "S", "W"]

  def initialize(y, x, d)
    @y = y
    @x = x
    @d = @@direction.index(d)
  end

  def get_status
    return @y, @x, @@direction[@d]
  end

  def move_forward(step = 1)
    case @d
    when 0 #N
      @y -= step
    when 1 #E
      @x += step
    when 2 #S
      @y += step
    when 3 #W
      @x -= step
    end
  end

  def turn(rotation, times = 1)
    if rotation == "L"
      @d = (@d - times) % @@direction.size
    elsif rotation == "R"
      @d = (@d + times) % @@direction.size
    end
  end
end

def solve(input_data)
  # 初期座標の設定
  x, y, n = input_data.shift.split.map(&:to_i)
  coord = Coordinate.new(y, x, "N")

  # n回移動して移動の度に座標を表示
  n.times do
    coord.turn(input_data.shift)
    coord.move_forward
    y, x = coord.get_status
    puts "#{x} #{y}"
  end
end

#solve(readlines.map(&:chomp))

input_data1 = <<~EOS
  3 5 1
  L
EOS

input_data2 = <<~EOS
  -18 45 6
  L
  L
  R
  R
  L
  R
EOS

solve(input_data2.split("\n"))

=begin
座標系での向きの変わる移動 (paizaランク B 相当)
Img 04 03 下記の問題をプログラミングしてみよう！
開始時点の x , y 座標,移動の回数 N が与えられます。
続くN行で移動の向き d1 ... dN が与えられるので、与えられた順に移動をしたときの各移動後の x , y 座標 を答えてください。
移動者ははじめ北を向いています。
なお、マスの座標系は下方向が y 座標の正の向き、右方向が x 座標の正の向きとします。
移動をするごとに向く方角が変わること・移動前に向いている方角によって同じ移動の向きでも座標の変化が違うことに気をつけてください。
例えば、上の図の状態から右に移動を行った場合、下の図のような状態になります。




▼　下記解答欄にコードを記入してみよう

入力される値
X Y N       
d1      
...     
dN


・ 1 行目には、開始時点の x , y 座標を表す X , Y, 移動の回数 N が与えられます。
・ 続く N 行 (1 ≦ i ≦ N) には、盤面の i 回目の移動の向きを表す文字 d_i が与えられます。

入力値最終行の末尾に改行が１つ入ります。
文字列は標準入力から渡されます。 標準入力からの値取得方法はこちらをご確認ください
期待する出力
N 行での出力
・ 各移動後の x , y 座標を出力してください。


x_1 y_1
...
x_N y_N
条件
すべてのテストケースにおいて、以下の条件をみたします。
・ -100 ≦ X, Y ≦ 100
・ 1 ≦ N ≦ 100
・ d は、L, R のいずれかでそれぞれ 左・右 に １ マス進むことを表す。

入力例1
3 5 1
L

出力例1
2 5

入力例2
-18 45 6
L
L
R
R
L
R

出力例2
-19 45
-19 46
-20 46
-20 45
-21 45
-21 44
=end
