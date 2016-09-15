
class Board
  def initialize(grid)
    @grid = grid
  end

  def self.make_board
    grid = Array.new(9) { [] }
    true_false = Array.new(71,false) + Array.new(10,true)
    true_false.shuffle!

    grid.each do |row|
      9.times { row << Tile.new(true_false.pop) }
    end
    Board.new(grid)
  end

  def render
    @grid.each do |row|
      row.each do |tile|
        print tile.render
      end
      puts "\n"
    end
  end

  def has_bomb?(move)
    row, col = move
    @grid[row][col].bombed
  end

  def all_bombs_flagged?
    @grid.each do |row|
      row.each do |tile|
        return false if tile.bombed && !tile.flagged
      end
    end
    true
  end

  def valid_move_pos?(move)
    row, col = move
    return false unless row.between?(0..@grid.length-1) && col.between?(0..@grid.length-1)
    return false if @grid[row][col].revealed
    true
  end

  def valid_move_type?(move)
    return false unless move.match(/[fFrR]{1}/)
  end
end
