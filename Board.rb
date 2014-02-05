require 'colorize'
require 'debugger'
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

  def in_check?(color)

    king_pos = nil
    @board.each do |row|
      row.each do |piece|
        king_pos = piece.pos if piece.class == King && piece.color == color
      end
    end
    other_color = (color == :white ? :black : :white)

    @board.each do |row|
      row.each do |piece|
        next if piece == nil
        return true if piece.moves.include?(king_pos) && piece.color == other_color
      end
    end

    false
  end

  def move(start, end_pos)
    raise StandardError if self[start] == nil
    if self[start].moves.include?(end_pos)
      self[start].pos = end_pos
      if self.in_check?(self[end_pos].color)
        self[end_pos].pos = start
        #raise PutYoSelfInCheckError
      end
    else
     # raise IllegalMoveError
    end
  end

end
