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
      break if board.valid_move_pos?(move, board)
    end
  end

  def get_move_type(board)
    puts "What do you want to do? Flag(F) or Reveal(R)?"
    loop do
      move = gets.chomp
      break if board.valid_move_type?(move, board)
    end
  end

end
