require 'colorize'

class Board
  attr_accessor :board
  def initialize
    @board = Array.new(8) {Array.new(8)}
  end

  def [](pos)
    x, y = pos[0], pos[1]
    @board[y][x]
  end

  def []=(pos, mark)
    x, y = pos[0], pos[1]
    @board[y][x] = mark
  end

  def on_board?(pos)
    x, y = pos[0], pos[1]

    return false if x > 7 || x < 0
    return false if y > 7 || y < 0
    true
  end

end
