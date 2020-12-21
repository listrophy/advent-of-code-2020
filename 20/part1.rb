class Tile
  attr_reader :id

  def initialize(str)
    title, *content = str.split("\n")
    @id = title.match(/\d+/)[0].to_i
    @sides = [
      content[0],
      content.map { _1.chars.last }.join,
      content[-1].reverse,
      content.map { _1.chars.first }.reverse.join
    ]
  end

  def side_a
    @sides
  end

  def side_b
    [
      @sides[0].reverse,
      @sides[3].reverse,
      @sides[2].reverse,
      @sides[1].reverse
    ]
  end
end

tiles = File.read('./input.txt').split("\n\n").map do |tile|
  Tile.new(tile)
end

puts(tiles.select do |tile|
  others = tiles.reject { _1 == tile }
  (tile.side_a.count do |side|
    others.any? do |other|
      (other.side_a + other.side_b).any? do |o_side|
        side == o_side
      end
    end
  end) == 2
end.map(&:id).reduce(&:*))
