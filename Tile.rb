class Tile
  attr_reader :bombed
  attr_accessor :flagged, :revealed

  def initialize(bombed)
    @bombed = bombed
    @flagged = false
    @revealed = false
    @value = bombed ? "*" : " "
  end

  def render
    if revealed
      return "#{@value}"
    else
      return "[x]"
    end
  end

end
