# 1 マスの陣取り (paizaランク C 相当)

class Player
  attr_accessor :y, :x, :territory

  def initialize(y, x)
    @y = y
    @x = x
    @territory = [[y, x]]
  end

  def get_status
    [@y, @x, @territory]
  end

  def add_territory
    vy = [1, 0, -1, 0]
    vx = [0, 1, 0, -1]
    @territory = vy.zip(vx).map { |dy, dx| [@y + dy, @x + dx] } | @territory
  end
end

class Field
  attr_accessor :field_data

  def initialize(h, w)
    @h = h
    @w = w
    @field_data = Array.new(h).map { Array.new(w, ".") }
  end

  def add_character(pos, c)
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

  def valid_range?(y, x)
    0 <= y && y < @h && 0 <= x && x < @w && @field_data[y][x] == "."
  end
end

def search_player(field_data, c = "*")
  y, x = nil, nil
  field_data.each_with_index do |line, idx|
    if line.include?(c)
      return [idx, line.index("*")]
    end
  end
end

def solve(input_data)
  h, w = input_data.shift.split.map(&:to_i)
  player_pos = search_player(input_data)

  field = Field.new(h, w)
  player = Player.new(*player_pos)
  player.add_territory
  field.add_character(player.territory, "*")
  field.show_field
end

#solve(readlines.map(&:chomp))

input_data1 = <<~EOS
  3 3
  ...
  .*.
  ...
EOS

input_data2 = <<~EOS
  10 10
  *.........
  ..........
  ..........
  ..........
  ..........
  ..........
  ..........
  ..........
  ..........
  ..........
EOS

solve(input_data2.split("\n"))

=begin
1 マスの陣取り (paizaランク C 相当)
盤面の情報が与えられます。現在プレイヤーのいるマスは '＊' になっており、そのマスはプレイヤーの陣地です。
プレイヤーは現在の陣地から上下左右に １ マス移動することで到達できるマスをプレイヤーの陣地にします。
プレイヤーの陣地を '＊' にした盤面を出力してください。

入力される値
H W     
S_0     
...     
S_(H-1)


・ 1 行目では、盤面の行数 H , 列数 W が与えられます。
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
・ S の各文字は '.' または '*'
・ '*' のマスは １ つ

入力例1
3 3
...
.*.
...

出力例1
.*.
***
.*.

入力例2
10 10
*.........
..........
..........
..........
..........
..........
..........
..........
..........
..........

出力例2
**........
*.........
..........
..........
..........
..........
..........
..........
..........
..........
=end
