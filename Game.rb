# encoding: utf-8
require './Board.rb'
require './Pieces.rb'
require './Error.rb'

class Game
  attr_reader :board
  def initialize()
    @turn = :black
    self.run

  end

  def run
    @board = Board.new
    self.place_pieces
    self.turn

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

  def turn
    p "display Board"
    while game_over == false
      begin
        self.display_board
        pair = get_user_input
        debugger
        @board.move(pair[0], pair[1])
        raise IllegalMoveError.new if @board[pair[0]] != nil
      rescue IllegalMoveError, NoPieceError => e
        puts e.class
        puts e.our_message
        retry
      end
      @turn = (@turn == :white ? :black : :white)
    end
    puts "GAME OVER!"
    self.display_board
  end

  def game_over
    return true if @board.checkmate?(@turn)
    return false
  end

  def get_user_input

      puts "Select the piece you would like to move, Please enter as array: [y,x]"
      start = gets.chomp
      start = [start[1].to_i, start[3].to_i]
      puts "Where would you like to move? Please enter as array: [y,x]"
      end_pos = gets.chomp
      end_pos = [end_pos[1].to_i, end_pos[3].to_i]

      [start, end_pos]
  end

  def display_board
    board = "0 1 2 3 4 5 6 7 -\n"
    8.times do |col|
      row_str = ""
      8.times do |row|
        tile = @board[[col, row]]
        row_str += " _ " if tile == nil
        row_str += " #{tile.display_value} " if tile != nil
      end
      row_str += " #{col}\n"
      board += row_str
    end
    puts board
  end

end
Game.new

