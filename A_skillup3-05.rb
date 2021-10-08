# 幅のある移動 (paizaランク B 相当)

class Player
  @@NESW = ["N", "E", "S", "W"]

  def initialize(y, x, d = "N")
    @y = y
    @x = x
    @d = @@NESW.index(d)
  end

  def get_status
    return @y, @x, @d
  end

  def turn(m)
    if m == "L"
      @d = (@d - 1) % @@NESW.size
    elsif m == "R"
      @d = (@d + 1) % @@NESW.size
    end
  end

  def move_forward(move = true)
    step = 1
    y, x = @y, @x
    case @d
    when 0
      y = @y - step
    when 1
      x = @x + step
    when 2
      y = @y + step
    when 3
      x = @x - step
    end
    if move
      @y, @x = y, x
    else
      return y, x
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

  def put_player(y, x)
    @field_data[y][x] = "*"
  end
end

def solve(input_data)
  h, w, sy, sx, n = input_data.shift.split.map(&:to_i)
  field_data = []
  h.times { field_data.push(input_data.shift) }
  field = Field.new(h, w, field_data)
  player = Player.new(sy, sx)
  field.put_player(sy, sx)

  done = false
  input_data.each do |order|
    m, step = order.split
    step = step.to_i
    player.turn(m)
    step.times do
      ny, nx = player.move_forward(false)
      if field.can_move?(ny, nx)
        player.move_forward
        field.put_player(ny, nx)
      else
        done = true
        break
      end
    end
    if done
      break
    end
  end
  field.show_field
end

#solve(readlines.map(&:chomp))

input_data1 = <<~EOS
  10 10 4 5 3
  .......#..
  ..........
  ..........
  #.........
  ..........
  ......#...
  ..........
  ....#.....
  ...#......
  ..........
  L 3
  R 1
  R 3
EOS

input_data2 = <<~EOS
  15 15 10 7 5
  ...............
  ...............
  ##.............
  ........#......
  ....#..........
  ...........#.#.
  ........#......
  #...#...#......
  #......#.......
  ...............
  .#.............
  ..#............
  ...............
  .......#..#...#
  ..........#....
  L 3
  L 1
  R 2
  R 1
  L 1
EOS

solve(input_data2.split("\n"))

=begin
幅のある移動 (paizaランク B 相当)
Img 04 03 下記の問題をプログラミングしてみよう！
マップの行数 H と列数 W ,障害物を # で移動可能な場所を . で表した H 行 W 列のマップ S_1 ... S_H ,現在の座標 sy , sx ,移動の回数 N が与えられます。
はじめは北を向いています。
続けて N 回の移動の向き d_1 ... d_N と移動するマス数 l_1...l_N が与えられます。
各移動が可能である場合、スタート位置を含む移動の際に通ったマップのマスを * に変更してください。移動できない場合、以降の移動を打ち切ってください。
移動が終了した時のマップを出力してください。
移動可能であるということは、以下の図の通り
「今いるマスから移動先のマスまでの間の全てのマスが移動可能である かつ 移動先がマップの範囲外でない」 ということを意味します。
なお、マスの座標系は左上端のマスの座標を ( y , x ) = ( 0 , 0 ) とし、
下方向が y 座標の正の向き、右方向が x 座標の正の向きとします。




▼　下記解答欄にコードを記入してみよう

入力される値
H W sy sx N        
S_0     
...     
S_(H-1)     
d_1 l_1     
...     
d_N l_N


・ 1 行目には盤面の行数を表す整数 H , 盤面の列数を表す整数 W , 現在の y, x 座標を表す sy sx , 移動する回数 N が与えられます。
・ 続く H 行のうち i 行目 (0 ≦ i < H) には、盤面の i 行目の文字をまとめた文字列 S_i が与えられ、 S_i の j 文字目は、盤面の i 行目の j 列目に書かれている文字を表します。(0 ≦ j < W)
・ 続く N 行のうち i 行目 (1 ≦ i ≦ N) には、i 回目の移動の向き d_i と移動のマス数 l_i が与えられます。

入力値最終行の末尾に改行が１つ入ります。
文字列は標準入力から渡されます。 標準入力からの値取得方法はこちらをご確認ください
期待する出力
H 行の出力(マップの出力)

条件
すべてのテストケースにおいて、以下の条件をみたします。

・ 1 ≦ H, W ≦ 20
・ 1 ≦ N ≦ 100
・ 0 ≦ sy < H , 0 ≦ sx < W
・ 1 ≦ l_i ≦ 20
・ S_i は W 文字の文字列
・ マップ上の (sy, sx) のマスは必ず '.'
・ S の各文字は '.' または '#'
・ d_i は、 L, R のいずれかであり、それぞれ 左・右 を意味します。

入力例1
10 10 4 5 3
.......#..
..........
..........
#.........
..........
......#...
..........
....#.....
...#......
..........
L 3
R 1
R 3

出力例1
.......#..
..........
..........
#.****....
..****....
......#...
..........
....#.....
...#......
..........

入力例2
15 15 10 7 5
...............
...............
##.............
........#......
....#..........
...........#.#.
........#......
#...#...#......
#......#.......
...............
.#.............
..#............
...............
.......#..#...#
..........#....
L 3
L 1
R 2
R 1
L 1

出力例2
...............
...............
##.............
........#......
....#..........
...........#.#.
........#......
#...#...#......
#......#.......
...............
.#..****.......
..#**..........
...............
.......#..#...#
..........#....
=end
