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
    available_moves = []
    dirs = self.move_dirs
    dirs.each do |dir|
      x, y = dir[0], dir[1]
      legal = true
      while legal
        move =  [@pos[0] + x, @pos[1] + y]
        if @board.valid_move?(move)
          available_moves << move
          x += dir[0]
          y += dir[1]
        else
          legal = false
        end
      end
    end
  end
end

class Rook < SlidingPiece

  def move_dirs
    HORIZONTAL
  end
end
class Bishop < SlidingPiece
  def move_dirs
    DIAG
  end
end
class Queen < SlidingPiece

  def move_dirs
    DIAG + HORIZONTAL
  end

end

class SteppingPiece < Piece

end

class Pawn < Piece

end
