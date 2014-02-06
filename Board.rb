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



  def dup_board
    duped_board = Board.new
    self.board.each do |row|
      row.each do |tile|
        if tile != nil

            tile_pos = [tile.pos[0], tile.pos[1]]
          tile.class.new(tile.color, tile_pos, duped_board)
        end
      end
    end
    duped_board
  end


  def move(start, end_pos)
    raise NoPieceError if self[start] == nil

    if dup_move?(start, end_pos)
      make_move(start, end_pos)
    end
  end

  def dup_move?(start, end_pos)
    duped_board = self.dup_board

    if duped_board[start].moves.include?(end_pos)
      duped_board[start].pos = end_pos
      duped_board[start], duped_board[end_pos] = nil, duped_board[start]
      duped_board[start].first_move = false if duped_board[start].class == Pawn

      raise PutYoSelfInCheckError if duped_board.in_check?(duped_board[end_pos].color)
      return true
    end

    false
  end

  def make_move(start, end_pos)
    self[start].pos = end_pos
    self[start], self[end_pos] = nil, self[start]
    self[start].first_move = false if self[start].class == Pawn
  end

  def checkmate?(color)
    @board.each do |row|
      row.each do |tile|
        if tile != nil && tile.color == color
          tile.moves.each do |move|
            if dup_move?(tile.pos, move)
              return false
            end
          end
        end
      end
    end

     return true
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


end





