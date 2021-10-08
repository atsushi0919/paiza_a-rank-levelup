# 座標系での移動・向き

class Coordinate
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
    else
      @d = (@d + times) % @@direction.size
    end
  end
end

def solve(input_data)
  y, x, d = input_data.shift.split
  y, x = [y, x].map(&:to_i)
  coord = Coordinate.new(y, x, d)
  coord.turn(input_data.shift)
  coord.move_forward
  puts coord.get_status.slice(0, 2).join(" ")
end

#solve(readlines.map(&:chomp))

input_data1 = <<~EOS
  4 2 N
  R
EOS

input_data2 = <<~EOS
  6 9 E
  R
EOS
input_data3 = <<~EOS
  -29 -13 W
  L
EOS
input_data4 = <<~EOS
  -46 14 S
  L
EOS
solve(input_data3.split("\n"))

=begin
座標系での移動・向き (paizaランク B 相当)
Img 04 03 下記の問題をプログラミングしてみよう！
開始時点の y , x 座標 と向いている方角 D が与えられます。
続く1行で移動の向き d が与えられるので、その向きに移動した後の y , x 座標 を答えてください。
移動前に向いている方角によって同じ移動の向きでも座標の変化が違うことに気をつけてください。
なお、マスの座標系は左上端のマスの座標を ( y , x ) = ( 0 , 0 ) とし、
下方向が y 座標の正の向き、右方向が x 座標の正の向きとします。

入力される値
Y X D       
d

・ 1 行目には、開始時点の y , x 座標を表す Y , X,　現在の向いている方角を表す文字 D が与えられます。
・ 2 行目には、移動の向きを表す文字 d が与えられます。

入力値最終行の末尾に改行が１つ入ります。
文字列は標準入力から渡されます。 標準入力からの値取得方法はこちらをご確認ください
期待する出力
1 行での出力
・ 移動した後の y , x 座標を出力してください。


y x
条件
すべてのテストケースにおいて、以下の条件をみたします。
・ -100 ≦ X, Y ≦ 100
・ D は、N, S, E, W のいずれかでそれぞれ 北・南・東・西 を意味する。
・ d は、L, R のいずれかでそれぞれ 左・右 に １ マス進むことを表す。

入力例1
4 2 N
R

出力例1
4 3

入力例2
6 9 E
R

出力例2
7 9
=end
