# マップからの座標取得

class Board
  def initialize(h, w)
    @h = h
    @w = w
    @square = Array.new(@h).map { Array.new(@w) }
  end

  def show_square
    @square.each do |line|
      puts line.join
    end
  end

  def place_piece(y, x, piece)
    @square[y][x] = piece
  end

  def is_validrange(y, x)
    if 0 <= y && y < @h && 0 <= x && x < @w
      return true
    else
      return false
    end
  end

  def is_surrounded(y, x, p)
    vy = [1, 0, -1, 0]
    vx = [0, 1, 0, -1]
    vy.zip(vx).each do |dy, dx|
      ny = y + dy
      nx = x + dx
      if is_validrange(ny, nx)
        if @square[ny][nx] != p
          return false
        end
      end
    end
    return true
  end

  def seek_piece(p)
    @square.each_with_index do |line, y|
      x = line.index(p)
      if x != nil
        return y, x
      end
    end
  end
end

def solve(input_data)
  h, w = input_data.shift.split.map(&:to_i)
  board = Board.new(h, w)
  input_data.map(&:chars).each_with_index do |line, y|
    line.each_with_index do |piece, x|
      board.place_piece(y, x, piece)
    end
  end
  puts board.seek_piece("#").join(" ")
end

#solve(readlines.map(&:chomp))

input_data1 = <<~EOS
  1 1
  #
EOS

input_data2 = <<~EOS
  3 3
  .#.
  ...
  ...
EOS

solve(input_data1.split("\n"))

=begin
マップからの座標取得 (paizaランク C 相当)
Img 04 03 下記の問題をプログラミングしてみよう！
マップの行数 H と列数 W とマップを表す H 行 W 列の文字列 S_1 ...S_H が与えられます。
要素が '#' になっているマスの y , x 座標 を答えてください。

なお、マスの座標系は左上端のマスの座標を ( y , x ) = ( 0 , 0 ) とし、
下方向が y 座標の正の向き、右方向が x 座標の正の向きとします。

▼　下記解答欄にコードを記入してみよう

入力される値
H W     
S_0     
...     
S_(H-1)


・ 1 行目には盤面の行数を表す整数 H , 盤面の列数を表す整数 W が与えられます。
・ 続く H 行のうち i 行目 (0 ≦ i < H) には、盤面の i 行目の文字をまとめた文字列 S_i が与えられ、 S_i の j 文字目は、盤面の i 行目の j 列目に書かれている文字を表します。(0 ≦ j < W)

入力値最終行の末尾に改行が１つ入ります。
文字列は標準入力から渡されます。 標準入力からの値取得方法はこちらをご確認ください
期待する出力
1行の出力
- 要素が '#' になっているマスの y , x 座標を 1 行で出力してください。

y x
条件
すべてのテストケースにおいて、以下の条件をみたします。

・ 1 ≦ H, W ≦ 20
・ S は W 文字の文字列
・ S の各文字は '.' または '#'
・ '#' のマスは必ず１つ

入力例1
1 1
#

出力例1
0 0

入力例2
3 3
.#.
...
...

出力例2
0 1
=end
