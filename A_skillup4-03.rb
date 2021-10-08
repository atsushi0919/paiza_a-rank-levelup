# 陣取りの結末 (paizaランク B 相当)

class Field
  def initialize(h, w, field_data)
    @h = h
    @w = w
    @field_data = field_data.each.map(&:chars)
    @start_pos = self.get_start_pos
  end

  def get_start_pos(c = "*")
    y, x = nil, nil
    @field_data.each_with_index do |line, idx|
      if line.include?(c)
        return [idx, line.index("*")]
      end
    end
  end

  def add_character(pos, c = "*")
    pos.each do |pos|
      y, x = pos
      if self.valid_range?(y, x)
        @field_data[y][x] = c
      end
    end
  end

  def show_field
    @field_data.each do |line|
      puts line.join
    end
  end

  def can_move?(y, x)
    0 <= y && y < @h && 0 <= x && x < @w && @field_data[y][x] == "."
  end

  def players_territory
    vy = [1, 0, -1, 0]
    vx = [0, 1, 0, -1]

    count = 0
    y, x = @start_pos
    @memo = @field_data.map(&:dup)
    @memo[y][x] = count.to_s
    queue = [@start_pos]
    while queue.size > 0
      y, x = queue.shift
      vy.zip(vx).each do |dy, dx|
        ny = y + dy
        nx = x + dx
        if self.can_move?(ny, nx) && @memo[ny][nx] == "."
          queue.append([ny, nx])
          count += 1
          @memo[ny][nx] = count.to_s
          @field_data[ny][nx] = "*"
        end
      end
    end
  end
end

def solve(input_data)
  h, w = input_data.shift.split.map(&:to_i)
  field = Field.new(h, w, input_data)
  field.players_territory
  field.show_field
end

#solve(readlines.map(&:chomp))

input_data1 = <<~EOS
  3 3
  *..
  ...
  ...
EOS

input_data2 = <<~EOS
  3 3
  *.#
  ..#
  ##.
EOS

solve(input_data2.split("\n"))

=begin
陣取りの結末 (paizaランク B 相当)
盤面の情報が与えられます。
現在プレイヤーのいるマスは '＊' になっており、そのマスはプレイヤーの陣地です。
プレイヤーは次の操作をできなくなるまで続けます。

・ プレイヤーは現在の陣地から上下左右に １ マス移動することで到達できるマスをプレイヤーの陣地にする。ただし障害物( '#' )のマスは陣地にできない。

操作を終えた後のプレイヤーの陣地を '＊' にした盤面を出力してください。

入力される値
H W     
S_0     
...     
S_(H-1)


・ 1行目では、盤面の行数 H , 列数 W が与えられます。
・ 続く H 行のうち i 行目 (0 ≦ i < H) には、盤面の i 行目の文字をまとめた文字列 S_i が与えられ、
S_i の j 文字目は、盤面の i 行目の j 列目に書かれている文字を表します。(0 ≦ j < W)

入力値最終行の末尾に改行が１つ入ります。
文字列は標準入力から渡されます。 標準入力からの値取得方法はこちらをご確認ください
期待する出力
操作後の盤面を H 行で出力してください。

条件
すべてのテストケースにおいて、以下の条件をみたします。

・ 1 ≦ H, W ≦ 20
・ S は W 文字の文字列
・ S の各文字は '.' または '*' または '#'
・ '*' のマスは １ つ

入力例1
3 3
*..
...
...

出力例1
***
***
***

入力例2
3 3
*.#
..#
##.

出力例2
**#
**#
##.
=end
