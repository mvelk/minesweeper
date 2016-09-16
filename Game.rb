require_relative 'Tile'
require_relative 'Player'
require_relative 'Board'
class Game

def initialize(player)
  @board = Board.make_board
  @player = player
  @move = nil
  @move_type = nil
end

def play_turn
  @board.render
  @move = @player.get_move_pos(@board)
  @move_type = @player.get_move_type(@board)
  execute_move
end

def execute_move
  if @move_type.downcase == "f"
    @board.toggle_flag(@move)
  else
    @board.reveal_square(@move)
  end
end

def run
  until over?
    play_turn
  end
  announce_winner
end

def over?
  return false if @move.nil?
   won? || lost?
end

def won?
  @board.all_bombs_flagged?
end

def lost?
  (@board.has_bomb?(@move) && @move_type.downcase == "r")
end

def announce_winner
  puts "You win" if won?
  puts "You lose" if lost?

end
end

if __FILE__ == $PROGRAM_NAME
  jane = Player.new("Jane")
  game = Game.new(jane)
  game.run
end
