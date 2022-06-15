#移動が可能かの判定・幅のある移動 (paizaランク B 相当)

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
end

def solve(input_data)
  h, w, sy, sx, n = input_data.shift.split.map(&:to_i)
  field_data = []
  h.times { field_data.push(input_data.shift) }
  field = Field.new(h, w, field_data)
  player = Player.new(sy, sx)

  input_data.each do |order|
    m, step = order.split
    step = step.to_i
    player.turn(m)
    step.times do |i|
      ny, nx = player.move_forward(false)
      if field.can_move?(ny, nx)
        player.move_forward
        if i == step - 1
          puts "#{ny} #{nx}"
        end
      else
        ny, nx = player.get_status
        puts "#{ny} #{nx}"
        puts "Stop"
        return
      end
    end
  end
end

#solve(readlines.map(&:chomp))

input_data1 = <<~EOS
  10 10 6 4 3
  ..#.....#.
  ..........
  ##.#......
  #.##....#.
  .##.#.....
  ........#.
  .#......#.
  .#........
  ...#......
  #.#.......
  L 2
  R 1
  L 4
EOS

input_data2 = <<~EOS
  15 15 6 4 7
  .......#.......
  ....#.......#.#
  .......#.....#.
  .......#.#...#.
  #......#.......
  #.........#....
  ..............#
  ..#...#....#..#
  ............#..
  ..#...##......#
  ##..#..#.#.....
  #..............
  ............#..
  ...#...........
  .#.........#.#.
  L 4
  L 3
  R 4
  R 5
  L 3
  L 2
  R 1
EOS

solve(input_data2.split("\n"))

=begin
移動が可能かの判定・幅のある移動 (paizaランク B 相当)
マップの行数 H と列数 W ,障害物を # で移動可能な場所を . で表した H 行 W 列のマップ S_1 ... S_H ,
現在の座標 sy, sx, 移動の回数 N が与えられます。
プレイヤーははじめ北を向いています。
続けて、 N 回の移動の向き d_1 ... d_N と移動するマス数 l_1 ... l_N が与えられます。
各移動が可能である場合、移動後の y , x 座標 を出力してください。
移動しきれない場合、移動できるところまで移動した後の座標を出力した後に "Stop" を出力して、以降の移動を打ち切ってください。
移動可能であるということは、以下の図の通り
「今いるマスから移動先のマスまでの間の全てのマスが移動可能である かつ 移動先がマップの範囲外でない」 ということを意味します。
なお、マスの座標系は左上端のマスの座標を ( y , x ) = ( 0 , 0 ) とし、
下方向が y 座標の正の向き、右方向が x 座標の正の向きとします。

入力される値
H W sy sx N        
S_0         
...     
S_(H-1)     
d_1 l_1     
...     
d_N l_N


・ 1 行目には盤面の行数を表す整数 H , 盤面の列数を表す整数 W , 現在の y, x 座標を表す sy sx ,
移動する回数 N が与えられます。
・ 続く H 行のうち i 行目 (0 ≦ i < H) には、盤面の i 行目の文字をまとめた文字列 S_i が与えられ、
S_i の j 文字目は、盤面の i 行目の j 列目に書かれている文字を表します。(0 ≦ j < W)
・ 続く N 行のうち i 行目 (1 ≦ i ≦ N) には、i 回目の移動の向き d_i と移動するマス数 l_i が与えられます。

入力値最終行の末尾に改行が１つ入ります。
文字列は標準入力から渡されます。 標準入力からの値取得方法はこちらをご確認ください
期待する出力
最大 N 行の出力
・ 各移動が可能である場合、移動後の y , x 座標 を出力してください。
・ 移動しきれない場合、移動できるところまで移動した後の座標を出力した後に "Stop" を出力して、以降の移動を打ち切ってください。

条件
すべてのテストケースにおいて、以下の条件をみたします。

・ 1 ≦ H, W ≦ 20
・ 1 ≦ N ≦ 100
・ 0 ≦ sy < H, 0 ≦ sx < W
・ 1 ≦ l_i ≦ 20
・ S_i は W 文字の文字列
・ マップ上の(sy, sx)のマスは必ず.
・ S の各文字は '.' または '#'
・ d_i は、 L, R のいずれかであり、それぞれ 左・右 を意味します。

入力例1


出力例1
6 2
5 2
5 0
Stop

入力例2
15 15 6 4 7
.......#.......
....#.......#.#
.......#.....#.
.......#.#...#.
#......#.......
#.........#....
..............#
..#...#....#..#
............#..
..#...##......#
##..#..#.#.....
#..............
............#..
...#...........
.#.........#.#.
L 4
L 3
R 4
R 5
L 3
L 2
R 1

出力例2
6 0
9 0
9 0
Stop
=end
