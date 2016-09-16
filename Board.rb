
class Board
  def initialize(grid)
    @grid = grid
  end

  def self.make_board
    grid = Array.new(9) { [] }
    true_false = Array.new(71,false) + Array.new(10,true)
    true_false.shuffle!

    grid.each_with_index do |row, r_idx|
      9.times { |c_idx| row << Tile.new(true_false.pop, [r_idx, c_idx]) }
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

  def toggle_flag(move)
    row, col = move
    @grid[row][col].flagged = @grid[row][col].flagged ? false : true
  end

  def get_hidden_neighbors(pos)
    row, col = pos
    neighbors = []
    offsets = [[0,1], [0,-1], [1,1], [1,0], [1,-1], [-1,1], [-1,0], [-1,-1]]
    offsets.each do |offset|
      r_off, c_off = offset
      neighbor_r, neighbor_c = row + r_off, col + c_off
      neighbors << @grid[neighbor_r][neighbor_c] if valid_move_pos?([neighbor_r, neighbor_c])
    end
    neighbors
  end

  def reveal_square(pos)
    row, col = pos
    @grid[row][col].revealed = true
    neighbors = get_hidden_neighbors([row,col])
    num_bombs_found = 0
    neighbors.each do |neighbor_tile|
      num_bombs_found += 1 if neighbor_tile.bombed
    end
    if num_bombs_found > 0
      @grid[row][col].value = "[#{num_bombs_found}]"
    else
      neighbors.each do |neighbor|
        unless neighbor.revealed
          reveal_square(neighbor.pos)
        end
      end
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
    return false unless row.between?(0,@grid.length-1) && col.between?(0,@grid.length-1)
    return false if @grid[row][col].revealed
    true
  end

  def valid_move_type?(move)
    return false unless move.match(/[fFrR]{1}/)
    true
  end
end
