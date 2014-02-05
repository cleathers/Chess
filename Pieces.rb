class Piece
  attr_reader :pos, :color, :display_value
  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
    @board[@pos] = self

  end

  def captured
    @pos = nil
  end

  def move(new_pos)
    @board[@pos, new_pos]
  end

  def valid_move?(move)
    if @board.on_board?(move)
      if @board[move] == nil
        true
      else
        false
      end
    end
  end

  def capture?(move)
    if @board.on_board?(move)
      piece = @board[move]
      if piece.color != self.color
         true
      else
        false
      end
    end
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
          moves << move
          x += dir[0]
          y += dir[1]
        elsif capture?(move)
          moves << move
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

  def to_s

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

class King < SteppingPiece

  def move_dirs
    KING_MOVES
  end
end

class Knight < SteppingPiece

  def move_dirs
    KNIGHT_MOVES
  end
end


class Pawn < Piece
  PAWN_MOVES_W = [[1,0],[1,-1],[1,1]]
  PAWN_MOVES_B = [[-1,0],[-1,-1],[-1,1]]
  attr_accessor :first_move

  def initialize(color, pos, board)
    super
    @first_move = true
    @display_value = "P"
  end

  def capture?(move)

    piece = @board[move] if @board.on_board?(move)
    if piece == nil
      false
    elsif piece.color != self.color
       true
    else
      false
    end
    # check on piece
  end

  def valid_move?(move)
    delta = move[1] - @pos[1]
    # move logic
    if delta == 0 || (@first_move && move[0] == @pos[0])
      if @board.on_board?(move)
        if @board[move] == nil
          true
        else
          false
        end
      end
    else
    #capture logic
      capture?(move)
    end

  end

  def moves
    moves = []
    debugger
    if @first_move

      first_move = (self.color == :black ? [-2,0] : [2,0])
      potential_move = [first_move[0] + @pos[0], first_move[1] + @pos[1]]
       if valid_move?(potential_move)

         moves << potential_move
       end
    end
    self.move_dirs.each do |dir|
      potential_move = [dir[0] + @pos[0], dir[1] + @pos[1]]
      moves << potential_move if valid_move?(potential_move)
    end
    p moves
  end

  def move_dirs
    if @color == :black
      PAWN_MOVES_B
    else
      PAWN_MOVES_W
    end

  end



end
