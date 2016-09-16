class Tile
  attr_reader :bombed, :pos
  attr_accessor :flagged, :revealed, :value

  def initialize(bombed, pos)
    @pos = pos
    @bombed = bombed
    @flagged = false
    @revealed = false
    @value = bombed ? "*" : "[ ]"
  end

  def render
    if revealed
      return "#{@value}"
    else
      return "[X]"
    end
  end

end
