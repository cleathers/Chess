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

  def dup_board
    duped_board = Board.new
    @board.each do |row|
      row.each do |tile|
        if tile != nil
          tile.class.new(tile.color, tile.pos, duped_board)
        end
      end
    end
    duped_board
  end


  def move(start, end_pos)
    debugger
    raise NoPieceError if self[start] == nil

    duped_board = self.dup_board
    if duped_board[start].moves.include?(end_pos)
      duped_board[start].pos = end_pos
      duped_board[start], duped_board[end_pos] = nil, duped_board[start]
      duped_board[start].first_move = false if duped_board[start].class == Pawn
    # Redo in_check? by somehow passing it the dupped board
  if !duped_board.in_check?(duped_board[end_pos].color)
    raise PutYoSelfInCheckError
  else
    if self[start].moves.include?(end_pos)
      self[start].pos = end_pos
      self[start], self[end_pos] = nil, self[start]
      self[start].first_move = false if self[start].class == Pawn
      raise IllegalMoveError
    end
  end

end
