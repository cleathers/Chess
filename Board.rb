require 'colorize'
class Board
  attr_accessor :board
  def initialize
    @board = Array.new(8) {Array.new(8)}
  end

  def [](pos)
    x, y = pos[0] pos[1]
    @board[x][y]
  end

  def []=(pos, mark)
    x, y = pos[0], pos[1]
    @rows[x][y] = mark
  end



end
