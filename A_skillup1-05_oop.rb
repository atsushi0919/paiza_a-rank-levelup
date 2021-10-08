# マップの判定 縦・横

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

  def is_surrounded(y, x, v)
    vy = [1, 0, -1, 0]
    vx = [0, 1, 0, -1]
    vy.zip(vx).each do |dy, dx|
      ny = y + dy
      nx = x + dx
      if is_validrange(ny, nx)
        if @square[ny][nx] != v
          return false
        end
      end
    end
    return true
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
  for y in 0...h
    for x in 0...w
      if board.is_surrounded(y, x, "#")
        puts "#{y} #{x}"
      end
    end
  end
end

solve(readlines.map(&:chomp))

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

#solve(input_data2.split("\n"))

=begin
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
=end
