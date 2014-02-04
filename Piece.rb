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

  def valid_move?(end_pos)

  end

  def capture?(end_pos)

  end
  # Check if move on board

end

class SlidingPiece < Piece
  HORIZONTAL = [[0,1],[0,-1],[1,0],[-1,0]]
  DIAG = [[1,1],[-1,-1],[1,-1],[-1,1]]
  def moves
    moves = []
    dirs = self.move_dirs
    dirs.each do |dir|
      x, y = dir[0], dir[1]
      legal = true
      while legal
        move =  [@pos[0] + x, @pos[1] + y]
        if valid_move?(move)
          available_moves << move
          x += dir[0]
          y += dir[1]
        elsif capture?(move)
          available_moves << move
          legal = false
        else
          legal = false
        end
      end
    end
    moves
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
  KNIGHT_MOVES = [[-2,-1],[-2,1],[-1,2],[1,2],[2,1],[2,-1],[1,-2],[-1,-2]]
  KING_MOVES = [[0,1],[0,-1],[1,0],[-1,0],[1,1],[-1,-1],[1,-1],[-1,1]]

  def moves
    moves = []
    self.move_dirs.each do |dir|
      potential_move = [dir[0] + @pos[0], dir[1] + @pos[1]]
      moves << potential_move if valid_move?(potential_move) || capture?(potential_move)
    end
    moves
  end

end

class King < SlidingPiece

  def move_dirs
    KING_MOVES
  end
end

class Knight < SlidingPiece

  def move_dirs
    KNIGHT_MOVES
  end
end


class Pawn < Piece
  PAWN_MOVES_W = [[0,1][-1,1][1,1]]
  PAWN_MOVES_B = [[0,-1][-1,-1][1,-1]]
  def initalize
    @first_move = true
  end

  def capture?(move)

  end

  def moves
    moves = []
    if @first_move
      @frist_move = false
      first_move = (self.color == "B" ? [0,-2] : [0,2])
      moves << first_move if valid_move?(first_move)
    end
    self.move_dirs.each do |dir|
      potential_move = [dir[0] + @pos[0], dir[1] + @pos[1]]
      moves << potential_move if valid_move?(potential_move) || capture?(potential_move)
    end

  end

  def move_dirs
    if @color == 'B'
      PAWN_MOVES_B
    else
      PAWN_MOVES_W
    end

  end


end
