#マップの判定・横 (paizaランク C 相当)

def solve(input_data)
  h, w = input_data.shift.split.map(&:to_i)
  lines = input_data.map(&:chars)

  for y in 0...h
    for x in 0...w
      if x == 0
        #puts "y=#{y} x=#{x}: #{lines[y][x+1]}"
        if lines[y][x + 1] == "#"
          puts "#{y} #{x}"
        end
      elsif x == w - 1
        #puts "y=#{y} x=#{x}: #{lines[y][x-1]}#{lines[y][x]}"
        if lines[y][x - 1] == "#"
          puts "#{y} #{x}"
        end
      else
        #puts "y=#{y} x=#{x}: #{lines[y][x-1]} #{lines[y][x+1]}"
        if lines[y][x - 1] == "#" && lines[y][x + 1] == "#"
          puts "#{y} #{x}"
        end
      end
    end
  end
end

# solve(readlines.map(&:chomp))

input_data1 = <<~EOS
  3 3
  #.#
  .#.
  ...
EOS

input_data2 = <<~EOS
  4 4
  ####
  ####
  ####
  ####
EOS

solve(input_data2.split("\n"))

=begin
マップの判定・横 (paizaランク C 相当)

行数 H , 列数 W の盤面があり、盤面の各マスには文字が 1 つだけ書かれています。
盤面が与えられるので、「左右のマスが "#" 」であるようなマスの座標を全て出力してください。
ただし、左端のマスの場合は「右のマスが "#" 」であれば、右端のマスの場合は「左のマスが "#" 」であれば条件を満たすものとします。

なお、マスの座標系は左上端のマスの座標を ( y , x ) = ( 0 , 0 ) とし、
下方向が y 座標の正の向き、右方向が x 座標の正の向きとします。

入力される値
H W     
S_0     
...     
S_(H-1)


・ 1 行目には盤面の行数を表す整数 H , 盤面の列数を表す整数 W が与えられます。
・ 続く H 行のうち i 行目 (0 ≦ i < H) には、盤面の i 行目の文字をまとめた文字列 S_i が与えられ、
S_i の j 文字目は、盤面の i 行目の j 列目に書かれている文字を表します。(0 ≦ j < W)

入力値最終行の末尾に改行が１つ入ります。
文字列は標準入力から渡されます。 標準入力からの値取得方法はこちらをご確認ください

期待する出力
・ 1 行以上 H×W 行以下の出力
条件を満たすマスの y , x 座標を出力してください。
左上 (y = 0,x = 0) のマスから順に、x 座標 , y 座標の順で増加するように出力してください。詳しくは入出力例を参考にしてください。


y_0 x_0        
...
条件
すべてのテストケースにおいて、以下の条件をみたします。

・ 1 ≦ H, W ≦ 20
・ S は W 文字の文字列
・ S の各文字は "." または "#"
・ 条件を満たすマスが少なくとも 1 つ以上存在します

入力例1
3 3
#.#
.#.
...

出力例1
0 1
1 0
1 2

入力例2
4 4
####
####
####
####

出力例2
0 0
0 1
0 2
0 3
1 0
1 1
1 2
1 3
2 0
2 1
2 2
2 3
3 0
3 1
3 2
3 3
=end
