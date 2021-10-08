#陣取りゲーム (paizaランク A 相当)

class Player
  attr_accessor :name, :territory, :border, :done

  def initialize(name, start_pos)
    @name = name
    @territory = [start_pos]
    @border = [start_pos]
  end
end

class Field
  @@MAP_CHIP = [".", "#"]
  attr_accessor :players

  def initialize(h, w, field_data)
    @h = h
    @w = w
    @field_data = field_data.each.map(&:chars)
    @players = []
    @turn = 0
  end

  def get_start_pos
    players = []
    @field_data.each_with_index do |line, y|
      line.each_with_index do |cell, x|
        if !@@MAP_CHIP.include? cell
          players << [cell, [y, x]]
          if players.size == 2
            return players.sort
          end
        end
      end
    end
  end

  def add_player(player)
    @players << player
  end

  def turn_processing
    player = @players[@turn % @players.size]
    self.get_territory(player) if player.border.size > 0
    @turn += 1
  end

  def show_field
    @field_data.each { |line| puts line.join }
  end

  # 有効範囲内かつ設置可能なマスならtrue
  def can_move?(y, x)
    (0...@h).include?(y) && (0...@w).include?(x) && @field_data[y][x] == "."
  end

  def gameover?
    @players.all? { |player| player.border.size == 0 }
  end

  def get_territory(player)
    vy = [1, 0, -1, 0]
    vx = [0, 1, 0, -1]
    border = player.border

    new_border = []
    while border.size > 0
      y, x = border.shift
      vy.zip(vx).each do |dy, dx|
        ny = y + dy
        nx = x + dx
        if self.can_move?(ny, nx)
          @field_data[ny][nx] = player.name
          player.territory << [ny, nx]
          new_border << [ny, nx]
        end
      end
    end
    player.border = new_border
  end

  def show_result
    players = @players.sort_by(&:name)
    res = players.map { |player| player.territory.size }
    puts res.join(" ")
    puts players[res.index(res.max)].name
  end
end

def solve(input_data)
  #入力データ読み込み
  h, w = input_data.shift.split.map(&:to_i)
  first_player = input_data.shift
  field = Field.new(h, w, input_data)

  # 攻撃順リスト
  players_param = field.get_start_pos
  players_param = players_param.reverse if first_player == "B"
  players_param.each { |param| field.add_player(Player.new(*param)) }

  # ゲーム終了判定までターンを進める
  while !field.gameover?
    field.turn_processing
  end

  # 結果表示
  field.show_result
end

#solve(readlines.map(&:chomp))

input_data1 = <<~EOS
  3 3
  A
  A..
  ...
  ..B
EOS

input_data2 = <<~EOS
  3 3
  B
  A.B
  ...
  ...
EOS

solve(input_data1.split("\n"))

=begin
陣取りゲーム (paizaランク A 相当)
A さんと B さんは次の操作を交互に繰り返すことで陣取りゲームをしようと考えました。
2 人の操作によって盤面が変化しなくなったらゲームを終了します。

・ 現在の陣地から上下左右に 1 マス移動することで到達できる、まだ誰の陣地でもない全てのマスを新たに陣地にする。
ただし、障害物( # )のマスは陣地にできない。新たに陣地にできるマスが無い場合、何もしない。

盤面の情報と、先行のプレイヤーの名前が与えられます。
盤面では、はじめに A さんのいるマスを 'A' , B さんのいるマスを 'B' で表します。
ゲーム終了時に A さん、 B さん、それぞれの陣地のマス数と勝った人の名前を出力してください。
なお、引き分けにはならないことが保証されています。

例として、ゲームが次のような状態でスタートした場合、

・ Aさんが先行のときは次のような結果になるので、
6 3
A

と出力してください。

・ Bさんが先行のときは次のような結果になるので、
3 6
B

と出力してください。

入力される値
H W     
N       
S_0     
...     
S_(H-1)


・ 1 行目では、マップの行数 H , 列数 W が与えられます。
・ 2 行目では、先行のプレイヤーの名前 N が与えられます。
・ 続く H 行のうち i 行目 (0 ≦ i < H) には、盤面の i 行目の文字をまとめた文字列 S_i が与えられ、
S_i の j 文字目は、盤面の i 行目の j 列目に書かれている文字を表します。(0 ≦ j < W)

入力値最終行の末尾に改行が１つ入ります。
文字列は標準入力から渡されます。 標準入力からの値取得方法はこちらをご確認ください
期待する出力
2 行の出力
二人のマス数の間には半角スペースを 1 つ出力してください。

A さんの陣地のマス数 B さんの陣地のマス数
勝者の名前

条件
すべてのテストケースにおいて、以下の条件をみたします。

・ 1 ≦ H, W ≦ 1000
・ N は 'A' か 'B'
・ S は W 文字の文字列
・ S の各文字は '.', '#', 'A', 'B'のいずれか
・ 'A' , 'B' のマスは１つ
・ 必ずゲームの勝者が決定する

入力例1
3 3
A
A..
...
..B

出力例1
6 3
A

入力例2
3 3
B
A.B
...
...

出力例2
3 6
B
=end
