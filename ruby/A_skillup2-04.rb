# 座標系での規則的な移動

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
  x, y, n = input_data.shift.split.map(&:to_i)
  coord = Coordinate.new(y, x, "E")
  count = 0
  step = 0.5
  while true
    move = step.ceil
    if count + move <= n
      count += move
    else
      move = n - count
      count = n
    end
    coord.move_forward(move)
    if count == n
      y, x = coord.get_status
      puts "#{x} #{y}"
      break
    else
      coord.turn("R")
      step += 0.5
    end
  end
end

#solve(readlines.map(&:chomp))

input_data1 = <<~EOS
  0 0 3
EOS

input_data2 = <<~EOS
  38 47 27
EOS

solve(input_data1.split("\n"))

=begin
座標系での規則的な移動 (paizaランク B 相当)
Img 04 03 下記の問題をプログラミングしてみよう！
開始時点の x , y 座標と移動の歩数 N が与えられます。
以下の図のように時計回りに渦を巻くように移動を N 歩行った後の x , y 座標 を答えてください。
なお、マスの座標系は下方向が y 座標の正の向き、右方向が x 座標の正の向きとします。



▼　下記解答欄にコードを記入してみよう

入力される値
X Y N


・ 1 行で、開始時点の x , y 座標を表す X , Y, 移動の歩数 N が与えられます。

入力値最終行の末尾に改行が１つ入ります。
文字列は標準入力から渡されます。 標準入力からの値取得方法はこちらをご確認ください
期待する出力
1行での出力
・ 移動を N 歩行った後の x , y 座標を出力してください。


x y
条件
すべてのテストケースにおいて、以下の条件を満たします。
・ -100 ≦ X, Y ≦ 100
・ 0 ≦ N ≦ 100

入力例1
0 0 3

出力例1
0 1

入力例2
38 47 27

出力例2
41 47
=end
