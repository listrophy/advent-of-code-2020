file = File.foreach('./input.txt', chomp: true)

puts(
  [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]].reduce(1) do |product, (right, down)|
    product *
      (file.rewind.each_slice(down).map(&:first).each_with_index.reduce(0) do |m, (line, idx)|
        m + (line[idx * right % line.length] == '#' ? 1 : 0)
      end)
  end
)
