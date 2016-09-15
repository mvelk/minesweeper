require_relative 'Tile'
require_relative 'Player'
require_relative 'Board'
class Game

def initialize(player)
  @board = Board.make_board
  @player = player
  @move = nil
end

def play_turn
  @board.render
  @move = @player.get_move_pos
end

def run
  until over?
    play_turn
  end
  announce_winner
end

def over?
  @board.has_bomb?(@move) || @board.all_bombs_flagged?
end

def announce_winner
  puts "You win" if @board.all_bombs_flagged?
  puts "You lose" if @board.has_bomb?(@move)

end

if __FILE__ == $PROGRAM_NAME
  jane = Player.new("Jane")
  game = Game.new(jane)
  game.run
end
