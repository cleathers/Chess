class PutYoSelfInCheckError < StandardError
  def message
    p "That move will place you in check."
  end
end
class IllegalMoveError < StandardError
  def message
    p "That is an illegal move"
  end
end
class NoPieceError < StandardError
  def message
    p "There is no piece at your start location."
  end
end

class IncorrectInputError < StandarError
  def message
    p "You have entered the input in an incorrect format."
  end

end