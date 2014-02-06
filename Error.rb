class PutYoSelfInCheckError < StandardError
  def our_message
    "That move will place you in check."
  end
end
class IllegalMoveError < StandardError
  def our_message
    "That is an illegal move"
  end
end
class NoPieceError < StandardError
  def our_message
    "There is no piece at your start location."
  end
end

class IncorrectInputError < StandardError
  def our_message
    "You have entered the input in an incorrect format."
  end

end