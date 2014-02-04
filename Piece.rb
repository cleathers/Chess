class Piece
  attr_reader :pos, :color
  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
  end

  def captured
    @pos = nil
  end

  def move(new_pos)
    @board[@pos, new_pos]
  end
  # Check if move on board

end

class SlidingPiece < Piece
  HORIZONTAL = [[0,1],[0,-1],[1,0],[-1,0]]
  DIAG = [[1,1],[-1,-1],[1,-1],[-1,1]]
  def moves

  end
end

class Rook < SlidingPiece

  def move_dirs
    move_dirs = []

      HORIZONTAL.each do |direction|

      end

  end
end

class SteppingPiece < Piece

end

class Pawn < Piece

end
