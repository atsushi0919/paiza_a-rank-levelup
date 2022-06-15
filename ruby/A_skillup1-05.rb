# マップの判定 縦・横

def is_validrange(y, x)
  if 0 <= y && y < $h && 0 <= x && x < $w
    return true
  else
    return false
  end
end

def is_surrounded(y, x, v = "#")
  vy = [1, 0, -1, 0]
  vx = [0, 1, 0, -1]

  result = false
  vy.zip(vx).each do |dy, dx|
    ny = y + dy
    nx = x + dx
    if is_validrange(ny, nx)
      if $board[ny][nx] == v
        result = true
      else
        return false
      end
    end
  end
  return result
end

def solve(input_data)
  $h, $w = input_data.shift.split.map(&:to_i)
  $board = input_data.map(&:chars)
  $memo = Array.new($h).map { Array.new($w, false) }

  for y in 0...$h
    for x in 0...$w
      if !$memo[y][x]
        if is_surrounded(y, x)
          puts "#{y} #{x}"
        end
      end
    end
  end
end

input_data1 = <<~EOS
  3 3
  ##.
  ###
  ...
EOS

input_data2 = <<~EOS
  10 10
  ##########
  ..........
  ##########
  ##########
  ..........
  #.#.#.#.#.
  .#.#.#.#.#
  #.#.#.#.#.
  .#.#.#.#.#
  ..........
EOS

solve(input_data2.split("\n"))
# solve(readlines.map(&:chomp))

"" "
入力例1
3 3
##.
###
...

出力例1
0 0
0 2

入力例2
10 10
##########
..........
##########
##########
..........
#.#.#.#.#.
.#.#.#.#.#
#.#.#.#.#.
.#.#.#.#.#
..........

出力例2
6 0
6 2
6 4
6 6
6 8
7 1
7 3
7 5
7 7
7 9
" ""
