class Player
  attr_reader :name, :wins, :losses
  def initialize(name)
    @name = name
    @wins = wins
    @losses = losses
  end

  def get_move_pos(board)
    puts "Where do you want to move?"
    loop do
      move = gets.chomp.split(',').map(&:to_i)
      board.valid_move_pos?(move)
      return move if board.valid_move_pos?(move)
    end
  end

  def get_move_type(board)
    puts "What do you want to do? Flag(F) or Reveal(R)?"
    loop do
      move_type = gets.chomp
      board.valid_move_type?(move_type)
      return move_type if board.valid_move_type?(move_type)
    end
  end

end
