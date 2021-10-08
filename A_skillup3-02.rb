# 移動が可能かの判定・方角 (paizaランク b 相当)

class Piece
  @@NESW = ["N", "E", "S", "W"]

  def initialize(y, x, d)
    @y = y
    @x = x
    @d = @@NESW.index(d)
  end

  def get_pos
    return @y, @x, @d
  end

  def move(m, step = 1)
    if m == "L"
      md = (@d - 1) % @@NESW.size
    else
      md = (@d + 1) % @@NESW.size
    end
    case md
    when 0
      @y -= step
    when 1
      @x += step
    when 2
      @y += step
    when 3
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

  def can_move?(y, x)
    if 0 <= y && y < @h && 0 <= x && x < @w && @field_data[y][x] == "."
      return true
    else
      return false
    end
  end
end

def solve(input_data)
  h, w, sy, sx, d, m = input_data.shift.split
  h, w, sy, sx = [h, w, sy, sx].map(&:to_i)
  field = Field.new(h, w, input_data)
  piece = Piece.new(sy, sx, d)

  piece.move(m)
  ny, nx = piece.get_pos
  if field.can_move?(ny, nx)
    puts "Yes"
  else
    puts "No"
  end
end

#solve(readlines.map(&:chomp))

input_data1 = <<~EOS
  2 6 0 4 E L
  ####..
  ##..#.
EOS

input_data2 = <<~EOS
  7 9 6 0 S R
  ..#.#..##
  ..#..#...
  #.......#
  #.#...###
  #.##....#
  .....#...
  ..##..#.#
EOS

solve(input_data2.split("\n"))

=begin
移動が可能かの判定・方向 (paizaランク b 相当)
マップの行数 h と列数 w ,障害物を # ,移動可能な場所を . で表した h 行 w 列のマップ s_1 ... s_h が与えられます。
続けて現在の座標 sy , sx ,現在向いている方角 d ,１マス移動する方向 m が与えられるので、
移動が可能かどうかを判定してください。
移動可能であるということは、以下の図の通り 「移動先が障害物でないかつ移動先がマップの範囲外でない」ということを意味します。
なお、マスの座標系は左上端のマスの座標を ( y , x ) = ( 0 , 0 ) とし、
下方向が y 座標の正の向き、右方向が x 座標の正の向きとします。

入力される値
h w sy sx d m      
s_0     
...     
s_(h-1)


・ 1 行目には盤面の行数を表す整数 h , 盤面の列数を表す整数 w , 現在の y, x 座標を表す sy sx ,
現在向いている方角 d , 1 マス移動する方向 m が与えられます。
・ 続く h 行のうち i 行目 (0 ≦ i < h) には、盤面の i 行目の文字をまとめた文字列 s_i が与えられ、
s_i の j 文字目は、盤面の i 行目の j 列目に書かれている文字を表します。(0 ≦ j < w)

入力値最終行の末尾に改行が１つ入ります。
文字列は標準入力から渡されます。 標準入力からの値取得方法はこちらをご確認ください
期待する出力
移動が可能である場合 "yes" を、不可能である場合 "no" を出力してください。

条件
すべてのテストケースにおいて、以下の条件をみたします。

・ 1 ≦ h, w ≦ 20
・ 0 ≦ sy < h , 0 ≦ sx < w
・ s_i は w 文字の文字列
・ マップ上の(sy, sx)のマスは必ず '.'
・ s の各文字は '.' または '#'
・ d は、 n, s, e, w のいずれかであり、それぞれ 北・南・東・西 を意味します。
・ m は、 l, r のいずれかであり、それぞれ 左・右 を意味します。

入力例1
2 6 0 4 E L
####..
##..#.

出力例1
No

入力例2
7 9 6 0 S R
..#.#..##
..#..#...
#.......#
#.#...###
#.##....#
.....#...
..##..#.#

出力例2
No
=end
