# 座標系での移動・方角

class Coordinate
  def initialize(y, x)
    @y = y
    @x = x
  end

  def get_coordinates
    return @y, @x
  end

  def move(direction)
    case direction
    when "N"
      @y -= 1
    when "S"
      @y += 1
    when "E"
      @x += 1
    when "W"
      @x -= 1
    end
  end
end

def solve(input_data)
  y, x, n = input_data.shift.split.map(&:to_i)
  coord = Coordinate.new(y, x)
  n.times do
    coord.move(input_data.shift)
    puts coord.get_coordinates.join(" ")
  end
end

#solve(readlines.map(&:chomp))

input_data1 = <<~EOS
  0 0 1
  N
EOS

input_data2 = <<~EOS
  5 10 4
  N
  W
  E
  S
EOS

solve(input_data2.split("\n"))

=begin
座標系での移動・方角 (paizaランク C 相当)
Img 04 03 下記の問題をプログラミングしてみよう！
開始時点の y , x 座標 と移動の回数 N が与えられます。
続く N 行で移動の方角 d_1 ... d_N が与えられるので、与えられた順に移動をしたときの各移動後の y , x 座標 を答えてください。
ただし、図の通り、上側（ y 軸の負の向き）を北とします。

なお、マスの座標系は左上端のマスの座標を ( y , x ) = ( 0 , 0 ) とし、
下方向が y 座標の正の向き、右方向が x 座標の正の向きとします。

▼　下記解答欄にコードを記入してみよう

入力される値
Y X N       
d_1     
...     
d_N

・ 1 行目には、開始時点の y , x 座標を表す Y , X, 移動の回数 N が与えられます。
・ 続く N 行 (1 ≦ i ≦ N) には、盤面の i 回目の移動の方角を表す文字 d_i が与えられます。

入力値最終行の末尾に改行が１つ入ります。
文字列は標準入力から渡されます。 標準入力からの値取得方法はこちらをご確認ください
期待する出力
N 行での出力
・ 各移動後の y , x 座標を出力してください。

y_1 x_1
...
y_N x_N
条件
すべてのテストケースにおいて、以下の条件をみたします。

・ 0 ≦ Y, X, N ≦100
・ d_i は、N, S, E, W のいずれかでそれぞれ 北・南・東・西 を意味する。

入力例1
0 0 1
N

出力例1
-1 0

入力例2
5 10 4
N
W
E
S

出力例2
4 10
4 9
4 10
5 10
=end
