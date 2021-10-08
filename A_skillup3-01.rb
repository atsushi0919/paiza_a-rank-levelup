# 移動が可能かの判定・方角 (paizaランク B 相当)

class Piece
  def initialize(y, x)
    @y = y
    @x = x
  end

  def get_pos
    return @y, @x
  end

  def move(m, step = 1)
    case m
    when "N"
      @y -= step
    when "E"
      @x += step
    when "S"
      @y += step
    when "W"
      @x -= step
    end
  end
end

class Field
  def initialize(h, w, field_data)
    @h = h
    @w = w
    @field_data = field_data.map(&:chars)
  end

  def show_field
    @field_data.each do |line|
      puts line.join
    end
  end

  def valid_range?(y, x)
    if 0 <= y && y < @h && 0 <= x && x < @w && @field_data[y][x] == "."
      return true
    else
      return false
    end
  end
end

def solve(input_data)
  h, w, sy, sx, m = input_data.shift.split
  h, w, sy, sx = [h, w, sy, sx].map(&:to_i)

  field = Field.new(h, w, input_data)
  piece = Piece.new(sy, sx)

  piece.move(m)
  ny, nx = piece.get_pos
  if field.valid_range?(ny, nx)
    puts "Yes"
  else
    puts "No"
  end
end

#solve(readlines.map(&:chomp))

input_data1 = <<~EOS
  3 3 1 1 E
  ..#
  ..#
  ...
EOS

input_data2 = <<~EOS
  9 2 4 0 S
  #.
  #.
  ..
  ##
  ..
  ..
  .#
  ..
  .#
EOS

solve(input_data2.split("\n"))

=begin
移動が可能かの判定・方角 (paizaランク B 相当)
Img 04 03 下記の問題をプログラミングしてみよう！
マップの行数 H と列数 W ,障害物を # で、移動可能な場所を . で表したH行W列のマップ S_1 ... S_H が与えられます。
続けて現在の座標 sy , sx ,１マス移動する方角 m が与えられるので、移動が可能かどうかを判定してください。
移動可能であるということは、以下の図の通り「移動先が障害物でない、かつ、移動先がマップの範囲外でない」ということを意味します。
なお、マスの座標系は左上端のマスの座標を ( y , x ) = ( 0 , 0 ) とし、
下方向が y 座標の正の向き、右方向が x 座標の正の向きとします。

入力される値
H W sy sx m     
S_0    
...     
S_(H-1)

・1 行目には盤面の行数を表す整数 H , 盤面の列数を表す整数 W , 現在の y, x 座標を表す sy sx , 1 マス移動する方角 m が与えられます。
・続く H 行のうち i 行目 (0 ≦ i < H) には、盤面の i 行目の文字をまとめた文字列 S_i が与えられ、 S_i の j 文字目は、盤面の i 行目の j 列目に書かれている文字を表します。(0 ≦ j < W)

入力値最終行の末尾に改行が１つ入ります。
文字列は標準入力から渡されます。 標準入力からの値取得方法はこちらをご確認ください
期待する出力
移動が可能である場合 "Yes" を、不可能である場合 "No" を出力してください。

条件
すべてのテストケースにおいて、以下の条件をみたします。

・ 1 ≦ H, W ≦ 20
・ 0 ≦ sy < H , 0 ≦ sx < W
・ S_i は W 文字の文字列
・ マップ上の(sy, sx)のマスは必ず '.'
・ S の各文字は '.' または '#'
・ m は、N, S, E, W のいずれかであり、それぞれ 北・南・東・西 を意味します。

入力例1
3 3 1 1 E
..#
..#
...

出力例1
No

入力例2
9 2 4 0 S
#.
#.
..
##
..
..
.#
..
.#

出力例2
Yes
=end
