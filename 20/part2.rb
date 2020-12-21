class Tile
  attr_accessor :id, :placed, :content, :subtiles

  def initialize(str)
    title, *content = str.split("\n")
    @content  = content.map(&:chars)
    @id = title.match(/\d+/)[0].to_i
    @placed = false
    @subtiles = [false, true].map do |flip|
      (0..3).map do |rot|
        Subtile.new(self, flip, rot)
      end
    end.flatten
  end

  def to_s
    @content.map(&:join).join("\n")
  end
end

class Subtile
  attr_accessor :tile, :placed, :content, :top, :bottom, :left, :right

  def initialize(tile, flip, rotate)
    @tile = tile
    @top, @bottom, @left, @right = nil
    @content = flip ? tile.content.transpose : tile.content.dup

    rotate.times do
      new_content = []
      @content.each do |row|
        row.each_with_index do |char, j|
          new_content[j] ||= []
          new_content[j].unshift(char)
        end
      end
      @content = new_content
    end
  end

  def matches?(line, on_my_side)
    case on_my_side
    when :top then line == @content[0]
    when :bottom then line == @content[-1]
    when :left then line == @content.map(&:first)
    when :right then line == @content.map(&:last)
    end
  end

  def top
    @content[0]
  end

  def bottom
    @content[-1]
  end

  def left
    @content.map(&:first)
  end

  def right
    @content.map(&:last)
  end

  def to_s
    @content.map(&:join).join("\n")
  end
end

tiles = File.read('./input.txt').split("\n\n").map do |tile|
  Tile.new(tile)
end

# subtiles = tiles.flat_map {|t| t.subtiles }

def tiles.subtiles
  flat_map {|t| t.subtiles}
end


curr = tiles.subtiles.first

loop do
  next_tile = tiles.subtiles.reject do |other|
    other.tile == curr.tile
  end.detect do |other|
    other.matches?(curr.top, :bottom)
  end

  break if next_tile.nil?
  curr = next_tile
end

loop do
  next_tile = tiles.subtiles.reject do |other|
    other.tile == curr.tile
  end.detect do |other|
    other.matches?(curr.left, :right)
  end

  break if next_tile.nil?
  curr = next_tile
end

grid = [[curr]]
tiles.delete(curr.tile)

curr_row = 0
width = nil

until tiles.empty?
  if curr_row == 0
    subtile = tiles.subtiles.detect do |other|
      other.matches?(grid[0].last.right, :left)
    end
    if subtile
      grid[0] << subtile
      tiles.delete(subtile.tile)
    else # finished with top row
      curr_row = 1
      width = grid[0].length
    end
  else
    subtile =
      if grid.last.length == width
        # start new row
        subtile = tiles.subtiles.detect do |other|
          other.matches?(grid.last.first.bottom, :top)
        end
        grid << [subtile]
        subtile
      else
        # continue row
        subtile = tiles.subtiles.detect do |other|
          other.matches?(grid.last.last.right, :left)
        end
        grid[-1] << subtile
        subtile
      end
    begin
      tiles.delete(subtile.tile)
    rescue
      grid.each do |row|
        (0...10).each do |subrow|
          row.each do |tile|
            print tile.content[subrow].join
          end
        end
        puts
      end
      puts "OH NO"
      exit
    end
  end
end

image = ""

grid.each do |row|
  (1...9).each do |subrow|
    row.each do |tile|
      image << tile.content[subrow][1...-1].join
    end
    image << "\n"
  end
end

image = image.split("\n").map(&:chars)

image = image.transpose

0.times do
  new_image = []
  image.each do |row|
    row.each_with_index do |char, j|
      new_image[j] ||= []
      new_image[j].unshift(char)
    end
  end
  image = new_image
end

monster = <<EOS
                  #
#    ##    ##    ###
 #  #  #  #  #  #
EOS

monster_width = monster.split("\n").map(&:length).max
monster_height = monster.split("\n").count

monster_coords = monster.split("\n").map.with_index do |line, row|
  line.chars.map.with_index do |char, col|
    char == ?# ? [row, col] : nil
  end.compact
end.flatten(1)

seen = 0
image_height = image.count
image_width = image.first.length

image.each_with_index do |row, i|
  next if (i + monster_height) >= image_height

  row.each_with_index do |char, j|
    next if (j + monster_width) >= image_width

    if monster_coords.all? {|(r,c)| image[i + r][j + c] == ?# }
      seen += 1
    end
  end
end

total_hashes = image.sum do |line|
  line.count { _1 == ?# }
end

hashes_in_monster = monster.scan(/#/).count

puts(total_hashes - hashes_in_monster * seen)
