# マップの判定・縦

def solve(input_data)
  h, w = input_data.shift.split.map(&:to_i)
  lines = input_data.map(&:chars)

  for y in 0...h
    for x in 0...w
      if y == 0
        #puts "y=#{y} x=#{x}: #{lines[y + 1][x]}"
        if lines[y + 1][x] == "#"
          puts "#{y} #{x}"
        end
      elsif y == h - 1
        #puts "y=#{y} x=#{x}: #{lines[y - 1][x]}"
        if lines[y - 1][x] == "#"
          puts "#{y} #{x}"
        end
      else
        #puts "y=#{y} x=#{x}: #{lines[y - 1][x]} #{lines[y + 1][x]}"
        if lines[y - 1][x] == "#" && lines[y + 1][x] == "#"
          puts "#{y} #{x}"
        end
      end
    end
  end
end

input_data1 = <<~EOS
  3 3
  ###
  ...
  ###
EOS

input_data2 = <<~EOS
  4 4
  #.#.
  .#.#
  .#.#
  #.#.
EOS

solve(input_data1.split("\n"))
# solve(readlines.map(&:chomp))

"" "
入力例1
3 3
###
...
###

出力例1
1 0
1 1
1 2

入力例2
4 4
#.#.
.#.#
.#.#
#.#.

出力例2
0 1
0 3
3 1
3 3
" ""
