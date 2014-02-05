require './Board.rb'
require './Pieces.rb'

class Game
  attr_reader :board
  def initialize()

    self.run
  end

  def run
    @board = Board.new
    self.place_pieces


  end

  def place_pieces
    8.times do |index|
      Pawn.new(:black, [6,index], @board)
    end
    8.times do |index|
      Pawn.new(:white, [1,index], @board)
    end
    [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook].each_with_index do |piece, index|
      piece.new(:black, [7, index], @board)
    end
    [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook].each_with_index do |piece, index|
      piece.new(:white, [0, index], @board)
    end
  end

end


